import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/article/%5Bslug%5D/bloc/article_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

part 'article_event.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _articleRepository;

  ArticleBloc({
    required ArticleRepository articleRepository,
    required String slug,
    Article? article,
  })  : _articleRepository = articleRepository,
        super(ArticleInitState(
          slug: slug,
          article: article,
        )) {
    on<ArticleInitEvent>(_articleInitEventHandler);

    add(ArticleInitEvent());
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
}
