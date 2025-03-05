import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/article/%5Bslug%5D/bloc/article_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

part 'article_event.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _articleRepository;
  final ToggleFavorite _toggleFavorite;

  ArticleBloc({
    required ArticleRepository articleRepository,
    required ToggleFavorite toggleFavorite,
    required String slug,
    Article? article,
  })  : _articleRepository = articleRepository,
        _toggleFavorite = toggleFavorite,
        super(ArticleInitState(
          slug: slug,
          article: article,
        )) {
    on<ArticleInitStreamEvent>(_articleInitStreamEventHandler);
    on<ArticleInitEvent>(_articleInitEventHandler);

    add(ArticleInitStreamEvent());
    add(ArticleInitEvent());
  }

  Future<void> _articleInitStreamEventHandler(
    ArticleInitStreamEvent event,
    Emitter<ArticleState> emit,
  ) async {
    await emit.forEach(
      _toggleFavorite.stream,
      onData: (data) {
        if (data.data == null || data.data?.slug != state.slug) return state;
        if (state is ArticleInitState) {
          return ArticleInitState(
            slug: state.slug,
            article: data.data,
          );
        } else if (state is ArticleHydratedState) {
          return ArticleHydratedState(
            slug: state.slug,
            article: data.data!,
          );
        }
        return state;
      },
    );
  }

  Future<void> _articleInitEventHandler(
    ArticleInitEvent event,
    Emitter<ArticleState> emit,
  ) async {
    if (state is ArticleHydratedState) return;

    final res = await _articleRepository.getArticle(state.slug);

    if (res.code != 200) {
      emit(ArticleErrorState(
        slug: state.slug,
        message: res.message ?? 'Unknown error',
      ));
      return;
    }

    if (res.data == null) {
      emit(ArticleErrorState(
        slug: state.slug,
        message: res.message ?? 'No article founded',
      ));
      return;
    }

    emit(ArticleHydratedState(
      slug: state.slug,
      article: res.data!,
    ));
  }

  @visibleForTesting
  void testForceSetState(ArticleState state) {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state);
  }
}
