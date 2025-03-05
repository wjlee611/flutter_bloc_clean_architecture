import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/bloc/home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ArticleRepository _articleRepository;
  final ToggleFavorite _toggleFavorite;

  HomeBloc({
    required ArticleRepository articleRepository,
    required ToggleFavorite toggleFavorite,
  })  : _articleRepository = articleRepository,
        _toggleFavorite = toggleFavorite,
        super(HomeState.init()) {
    on<HomeInitStreamEvent>(_homeInitStreamEventHandler);
    on<HomeLoadMoreArticlesEvent>(_homeLoadMoreArticlesEventHandler);

    add(HomeInitStreamEvent());
    add(HomeLoadMoreArticlesEvent());
  }

  Future<void> _homeInitStreamEventHandler(
    HomeInitStreamEvent event,
    Emitter<HomeState> emit,
  ) async {
    await emit.forEach(
      _toggleFavorite.stream,
      onData: (data) {
        if (data.data == null) return state;
        final updatedArticles = state.articles.map((article) {
          if (article.slug == data.data!.slug) {
            return data.data!;
          }
          return article;
        }).toList();
        return state.copyWith(articles: updatedArticles);
      },
    );
  }

  Future<void> _homeLoadMoreArticlesEventHandler(
    HomeLoadMoreArticlesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (!event.force &&
        state.status != ELoadingStatus.init &&
        state.status != ELoadingStatus.loaded) {
      return;
    }
    emit(state.copyWith(status: ELoadingStatus.loading));

    final res = await _articleRepository.getArticles(
      offset: state.page,
      limit: 20,
    );

    if (res.code != 200) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: res.message,
      ));
      return;
    }

    if (res.data == null || res.data!.isEmpty) {
      emit(state.copyWith(
        status: ELoadingStatus.done,
        message: 'No more articles',
      ));
      return;
    }

    emit(state.copyWith(
      status: ELoadingStatus.loaded,
      articles: state.articles + res.data!,
      page: state.page + 1,
    ));
  }

  @visibleForTesting
  void testForceSetState(HomeState state) {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state);
  }
}
