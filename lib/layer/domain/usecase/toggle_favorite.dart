import 'package:flutter_bloc_clean_architecture/core/usecase/base_stream_usecase.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class ToggleFavorite with BaseStreamUsecase<BaseResponseModel<Article>> {
  final ArticleRepository _articleRepository;

  ToggleFavorite({required ArticleRepository articleRepository})
      : _articleRepository = articleRepository;

  Future<void> call({
    required Article article,
    required bool toFavorite,
  }) async {
    // Instant update
    final tempArticleJson = article.toJson();
    tempArticleJson['favorited'] = toFavorite;
    yieldData(BaseResponseModel(
      code: 299,
      data: Article.fromJson(tempArticleJson),
    ));

    late final BaseResponseModel<Article> updatedArticleRes;
    if (toFavorite) {
      updatedArticleRes =
          await _articleRepository.favoriteArticle(article.slug);
    } else {
      updatedArticleRes =
          await _articleRepository.unFavoriteArticle(article.slug);
    }
    if (updatedArticleRes.code != 200) {
      // Error case: rollback
      yieldData(
        BaseResponseModel(
          code: updatedArticleRes.code,
          message: updatedArticleRes.message,
          data: article,
        ),
      );
    } else {
      yieldData(updatedArticleRes);
    }
  }
}
