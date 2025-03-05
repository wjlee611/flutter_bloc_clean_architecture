import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/app_consts.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/article_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/article/%5Bslug%5D/bloc/article_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/article/%5Bslug%5D/bloc/article_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String slug1 = '1-slug';
  const String slug2 = '2-slug';
  late final Article article1;
  late final Article article2;

  setUpAll(() async {
    article1 = Article(
      author: Profile(
        username: '1 author',
        following: false,
      ),
      slug: '1-slug',
      title: 'title 1',
      description: 'description 1',
      body: 'body 1',
      tagList: [
        '1 tag 1',
        '1 tag 2',
      ],
      favorited: false,
      favoritesCount: 1,
      createdAt: AppConsts.dateNow,
      updatedAt: AppConsts.dateNow,
    );
    article2 = Article(
      author: Profile(
        username: '2 author',
        following: true,
      ),
      slug: '2-slug',
      title: 'title 2',
      description: 'description 2',
      body: 'body 2',
      tagList: [
        '2 tag 1',
        '2 tag 2',
      ],
      favorited: true,
      favoritesCount: 2,
      createdAt: AppConsts.dateNow,
      updatedAt: AppConsts.dateNow,
    );
  });

  group('[OK] ArticleBloc', () {
    late final ArticleRepository articleRepository;
    late final ToggleFavorite toggleFavorite;

    setUpAll(() {
      articleRepository = ArticleRepositoryMockImpl(delayms: 1);
      toggleFavorite = ToggleFavorite(articleRepository: articleRepository);
    });

    blocTest<ArticleBloc, ArticleState>(
      'Test ArticleBloc init',
      build: () => ArticleBloc(
        articleRepository: articleRepository,
        toggleFavorite: toggleFavorite,
        slug: slug1,
      ),
      act: (bloc) async {
        // On the bloc constructor, trigger the init event.
        // The first state change won't happen until after
        // the init event has been processed, so wait.
        await Future.delayed(Duration(milliseconds: 50));
      },
      expect: () => [
        ArticleHydratedState(slug: slug1, article: article1),
      ],
    );

    blocTest<ArticleBloc, ArticleState>(
      'Test ArticleBloc toggle favorite',
      build: () {
        return ArticleBloc(
          articleRepository: articleRepository,
          toggleFavorite: toggleFavorite,
          slug: slug2,
        );
      },
      act: (bloc) async {
        await Future.delayed(Duration(milliseconds: 50));
        toggleFavorite.call(article: article2, toFavorite: false);
        await Future.delayed(Duration(milliseconds: 50));
        toggleFavorite.call(article: article2, toFavorite: true);
      },
      // [wait]: The duration of the waiting time between calling
      // after the act function and checking the expect.
      wait: const Duration(milliseconds: 50),
      expect: () => [
        ArticleHydratedState(
          slug: slug2,
          article: article2,
        ),
        ArticleHydratedState(
          slug: slug2,
          article: Article.fromJson(
            article2.toJson()..update('favorited', (value) => false),
          ),
        ),
        ArticleHydratedState(
          slug: slug2,
          article: Article.fromJson(
            article2.toJson()
              ..update('favorited', (value) => false)
              ..update(
                  'updatedAt',
                  (value) => DateTime.parse(value)
                      .add(Duration(seconds: 1))
                      .toIso8601String()),
          ),
        ),
        ArticleHydratedState(
          slug: slug2,
          article: article2,
        ),
        ArticleHydratedState(
          slug: slug2,
          article: Article.fromJson(
            article2.toJson()
              ..update(
                  'updatedAt',
                  (value) => DateTime.parse(value)
                      .add(Duration(seconds: 1))
                      .toIso8601String()),
          ),
        ),
      ],
    );
  });

  group('[404 ERROR] ArticleBloc', () {
    late final ArticleRepository articleRepository;
    late final ToggleFavorite toggleFavorite;

    setUpAll(() {
      articleRepository = ArticleRepositoryMockImpl(errorCode: 404, delayms: 1);
      toggleFavorite = ToggleFavorite(articleRepository: articleRepository);
    });

    blocTest<ArticleBloc, ArticleState>(
      'Test ArticleBloc init',
      build: () => ArticleBloc(
        articleRepository: articleRepository,
        toggleFavorite: toggleFavorite,
        slug: slug1,
      ),
      act: (bloc) async {
        await Future.delayed(Duration(milliseconds: 50));
      },
      expect: () => [
        ArticleErrorState(slug: slug1, message: '404-error'),
      ],
    );

    blocTest<ArticleBloc, ArticleState>(
      'Test ArticleBloc toggle favorite from error',
      build: () => ArticleBloc(
        articleRepository: articleRepository,
        toggleFavorite: toggleFavorite,
        slug: slug2,
      ),
      act: (bloc) async {
        await Future.delayed(Duration(milliseconds: 50));
        toggleFavorite.call(article: article2, toFavorite: false);
        await Future.delayed(Duration(milliseconds: 50));
        toggleFavorite.call(article: article2, toFavorite: true);
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        ArticleErrorState(slug: slug2, message: '404-error'),
      ],
    );

    blocTest<ArticleBloc, ArticleState>(
      'Test ArticleBloc toggle favorite from loaded',
      build: () => ArticleBloc(
        articleRepository: articleRepository,
        toggleFavorite: toggleFavorite,
        slug: slug2,
      ),
      // One for init error
      // Another one for testForceSetState
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration(milliseconds: 50));
        bloc.testForceSetState(ArticleHydratedState(
          slug: slug2,
          article: article2,
        ));

        toggleFavorite.call(article: article2, toFavorite: false);
        await Future.delayed(Duration(milliseconds: 50));
        toggleFavorite.call(article: article2, toFavorite: true);
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        ArticleHydratedState(
          slug: slug2,
          article: Article.fromJson(
            article2.toJson()..update('favorited', (value) => false),
          ),
        ),
        ArticleHydratedState(
          slug: slug2,
          article: article2,
        ),
        // Second toggleFavorite returns same(checked by equatable) state.
        // So, state change didn't triggered.
      ],
    );
  });
}
