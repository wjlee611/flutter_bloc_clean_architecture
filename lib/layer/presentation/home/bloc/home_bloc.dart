import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/bloc/home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ArticleRepository _articleRepository;

  HomeBloc({
    required ArticleRepository articleRepository,
  })  : _articleRepository = articleRepository,
        super(HomeState.init()) {
    on<HomeLoadMoreArticlesEvent>(_homeLoadMoreArticlesEventHandler);

    add(HomeLoadMoreArticlesEvent());
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
}
