import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/app_consts.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/article_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final Article article3;
  late final Article article4;

  setUpAll(() async {
    article3 = Article(
      author: Profile(
        username: '3 author',
        following: false,
      ),
      slug: '3-slug',
      title: 'title 3',
      description: 'description 3',
      body: 'body 3',
      tagList: [
        '3 tag 1',
        '3 tag 2',
      ],
      favorited: false,
      favoritesCount: 3,
      createdAt: AppConsts.dateNow,
      updatedAt: AppConsts.dateNow,
    );
    article4 = Article(
      author: Profile(
        username: '4 author',
        following: true,
      ),
      slug: '4-slug',
      title: 'title 4',
      description: 'description 4',
      body: 'body 4',
      tagList: [
        '4 tag 1',
        '4 tag 2',
      ],
      favorited: true,
      favoritesCount: 4,
      createdAt: AppConsts.dateNow,
      updatedAt: AppConsts.dateNow,
    );
  });

  group('[OK] HomeBloc', () {
    late final ArticleRepository articleRepository;
    late final ToggleFavorite toggleFavorite;

    setUpAll(() {
      articleRepository = ArticleRepositoryMockImpl(delayms: 1);
      toggleFavorite = ToggleFavorite(articleRepository: articleRepository);
    });

    blocTest<HomeBloc, HomeState>(
      'Test HomeLoadMoreArticlesEvent',
      build: () => HomeBloc(
        articleRepository: articleRepository,
        toggleFavorite: toggleFavorite,
      ),
      act: (bloc) async {
        await Future.delayed(Duration(milliseconds: 50));
        bloc.add(HomeLoadMoreArticlesEvent());
        await Future.delayed(Duration(milliseconds: 50));
        bloc.add(HomeLoadMoreArticlesEvent());
        await Future.delayed(Duration(milliseconds: 50));
        bloc.add(HomeLoadMoreArticlesEvent());
        await Future.delayed(Duration(milliseconds: 50));
        bloc.add(HomeLoadMoreArticlesEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        // init loading
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loading)
            .having((state) => state.articles.length, 'articles.length', 0),
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loaded)
            .having((state) => state.articles.length, 'articles.length', 20),
        // event loading
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loading)
            .having((state) => state.articles.length, 'articles.length', 20),
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loaded)
            .having((state) => state.articles.length, 'articles.length', 40),
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loading)
            .having((state) => state.articles.length, 'articles.length', 40),
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loaded)
            .having((state) => state.articles.length, 'articles.length', 60),
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loading)
            .having((state) => state.articles.length, 'articles.length', 60),
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.done)
            .having((state) => state.articles.length, 'articles.length', 60),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Test HomeBloc toggle favorite',
      build: () => HomeBloc(
        articleRepository: articleRepository,
        toggleFavorite: toggleFavorite,
      ),
      act: (bloc) async {
        await Future.delayed(Duration(milliseconds: 50));
        toggleFavorite.call(article: article3, toFavorite: true);
        await Future.delayed(Duration(milliseconds: 50));
        toggleFavorite.call(article: article4, toFavorite: false);
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        // init loading
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loading)
            .having((state) => state.articles.length, 'articles.length', 0),
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loaded)
            .having((state) => state.articles.length, 'articles.length', 20),
        // event loading
        isA<HomeState>().having(
          (state) => state.articles.contains(Article.fromJson(
            article3.toJson()..update('favorited', (value) => true),
          )),
          'article3',
          true,
        ),
        isA<HomeState>().having(
          (state) => state.articles.contains(Article.fromJson(
            article3.toJson()
              ..update('favorited', (value) => true)
              ..update(
                'updatedAt',
                (value) => DateTime.parse(value)
                    .add(Duration(seconds: 1))
                    .toIso8601String(),
              ),
          )),
          'article3',
          true,
        ),
        isA<HomeState>().having(
          (state) => state.articles.contains(Article.fromJson(
            article4.toJson()..update('favorited', (value) => false),
          )),
          'article4',
          true,
        ),
        isA<HomeState>().having(
          (state) => state.articles.contains(Article.fromJson(
            article4.toJson()
              ..update('favorited', (value) => false)
              ..update(
                'updatedAt',
                (value) => DateTime.parse(value)
                    .add(Duration(seconds: 1))
                    .toIso8601String(),
              ),
          )),
          'article4',
          true,
        ),
      ],
    );
  });

  group('[404 ERROR] HomeBloc', () {
    late final ArticleRepository articleRepository;
    late final ToggleFavorite toggleFavorite;

    setUpAll(() {
      articleRepository = ArticleRepositoryMockImpl(errorCode: 404, delayms: 1);
      toggleFavorite = ToggleFavorite(articleRepository: articleRepository);
    });

    blocTest<HomeBloc, HomeState>(
      'Test HomeLoadMoreArticlesEvent',
      build: () => HomeBloc(
        articleRepository: articleRepository,
        toggleFavorite: toggleFavorite,
      ),
      act: (bloc) async {
        await Future.delayed(Duration(milliseconds: 50));
        bloc.add(HomeLoadMoreArticlesEvent());
        await Future.delayed(Duration(milliseconds: 50));
        bloc.add(HomeLoadMoreArticlesEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.loading)
            .having((state) => state.articles.length, 'articles.length', 0),
        isA<HomeState>()
            .having((state) => state.status, 'status', ELoadingStatus.error)
            .having((state) => state.articles.length, 'articles.length', 0)
            .having((state) => state.message, 'message', '404-error'),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Test HomeBloc toggle favorite',
      build: () => HomeBloc(
        articleRepository: articleRepository,
        toggleFavorite: toggleFavorite,
      ),
      // Two for init error
      // Another one for testForceSetState
      skip: 3,
      act: (bloc) async {
        await Future.delayed(Duration(milliseconds: 50));
        bloc.testForceSetState(HomeState(
          status: ELoadingStatus.loaded,
          articles: [article3, article4],
          page: 1,
        ));

        toggleFavorite.call(article: article3, toFavorite: true);
        await Future.delayed(Duration(milliseconds: 50));
        toggleFavorite.call(article: article4, toFavorite: false);
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.articles.contains(Article.fromJson(
            article3.toJson()..update('favorited', (value) => true),
          )),
          'article3',
          true,
        ),
        isA<HomeState>().having(
          (state) => state.articles.contains(Article.fromJson(
            article3.toJson()..update('favorited', (value) => false),
          )),
          'article3',
          true,
        ),
        isA<HomeState>().having(
          (state) => state.articles.contains(Article.fromJson(
            article4.toJson()..update('favorited', (value) => false),
          )),
          'article4',
          true,
        ),
        isA<HomeState>().having(
          (state) => state.articles.contains(Article.fromJson(
            article4.toJson()..update('favorited', (value) => true),
          )),
          'article4',
          true,
        ),
      ],
    );
  });
}
