import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/app_consts.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/article_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/widget/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/widget/favorite/bloc/favorite_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final Article article1;
  late final Article article2;

  setUpAll(() {
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

  group('[OK] FavoriteBloc', () {
    late final ArticleRepository articleRepository;
    late final ToggleFavorite toggleFavorite;

    setUpAll(() {
      articleRepository = ArticleRepositoryMockImpl(delayms: 1);
      toggleFavorite = ToggleFavorite(articleRepository: articleRepository);
    });

    blocTest<FavoriteBloc, FavoriteState>(
      'Test FavoriteFavorEvent',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article1,
      ),
      act: (bloc) {
        bloc.add(FavoriteFavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loaded),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'Test FavoriteFavorEvent rappid tap',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article1,
      ),
      act: (bloc) {
        bloc.add(FavoriteFavorEvent());
        bloc.add(FavoriteFavorEvent());
        bloc.add(FavoriteFavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loaded),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'Test FavoriteUnfavorEvent',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article2,
      ),
      act: (bloc) {
        bloc.add(FavoriteUnfavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loaded),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'Test FavoriteUnfavorEvent rappid tap',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article2,
      ),
      act: (bloc) {
        bloc.add(FavoriteUnfavorEvent());
        bloc.add(FavoriteUnfavorEvent());
        bloc.add(FavoriteUnfavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loaded),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'Test Custom',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article1,
      ),
      act: (bloc) async {
        bloc.add(FavoriteFavorEvent());
        bloc.add(FavoriteFavorEvent());
        bloc.add(FavoriteFavorEvent());
        await Future.delayed(Duration(milliseconds: 50));
        bloc.add(FavoriteUnfavorEvent());
        bloc.add(FavoriteUnfavorEvent());
        bloc.add(FavoriteUnfavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loaded),
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loaded),
      ],
    );
  });

  group('[404 ERROR] FavoriteBloc', () {
    late final ArticleRepository articleRepository;
    late final ToggleFavorite toggleFavorite;

    setUpAll(() {
      articleRepository = ArticleRepositoryMockImpl(errorCode: 404, delayms: 1);
      toggleFavorite = ToggleFavorite(articleRepository: articleRepository);
    });

    blocTest<FavoriteBloc, FavoriteState>(
      'Test FavoriteFavorEvent',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article1,
      ),
      act: (bloc) {
        bloc.add(FavoriteFavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loaded),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'Test FavoriteFavorEvent rappid tap',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article1,
      ),
      act: (bloc) {
        bloc.add(FavoriteFavorEvent());
        bloc.add(FavoriteFavorEvent());
        bloc.add(FavoriteFavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loaded),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'Test FavoriteUnfavorEvent',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article2,
      ),
      act: (bloc) {
        bloc.add(FavoriteUnfavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loaded),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'Test FavoriteUnfavorEvent rappid tap',
      build: () => FavoriteBloc(
        toggleFavorite: toggleFavorite,
        article: article2,
      ),
      act: (bloc) {
        bloc.add(FavoriteUnfavorEvent());
        bloc.add(FavoriteUnfavorEvent());
        bloc.add(FavoriteUnfavorEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        FavoriteFavorState(status: ELoadingStatus.loading),
        FavoriteUnfavorState(status: ELoadingStatus.loading),
        FavoriteFavorState(status: ELoadingStatus.loaded),
      ],
    );
  });
}
