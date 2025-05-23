import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

abstract class ArticleRepository {
  Future<BaseResponseModel<List<Article>>> getArticles({
    String? tag,
    String? author,
    String? favorited,
    required int limit,
    required int offset,
  });

  Future<BaseResponseModel<Article>> getArticle(String slug);

  Future<BaseResponseModel<Article>> favoriteArticle(String slug);

  Future<BaseResponseModel<Article>> unFavoriteArticle(String slug);
}
