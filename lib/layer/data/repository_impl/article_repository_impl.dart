import 'package:flutter_bloc_clean_architecture/layer/data/source/network/app_api.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<BaseResponseModel<List<Article>>> getArticles({
    String? tag,
    String? author,
    String? favorited,
    required int limit,
    required int offset,
  }) async {
    final res = await AppApi.instance.swaggerApi((api) async {
      return await api.getArticlesApi().getArticles(
            tag: tag,
            author: author,
            favorited: favorited,
            limit: limit,
            offset: offset,
          );
    });
    return BaseResponseModel(
      code: res.statusCode ?? 500,
      message: res.statusMessage,
      data: res.data?.articles
              .map((article) => Article.fromJson(article.toJson()))
              .toList() ??
          <Article>[],
    );
  }

  @override
  Future<BaseResponseModel<Article>> getArticle(String slug) async {
    final res = await AppApi.instance.swaggerApi((api) async {
      return await api.getArticlesApi().getArticle(
            slug: slug,
          );
    });
    return BaseResponseModel(
      code: res.statusCode ?? 500,
      message: res.statusMessage,
      data: res.data?.article,
    );
  }

  @override
  Future<BaseResponseModel<Article>> favoriteArticle(String slug) async {
    final res = await AppApi.instance.swaggerApi((api) async {
      return await api.getFavoritesApi().createArticleFavorite(
            slug: slug,
          );
    });
    return BaseResponseModel(
      code: res.statusCode ?? 500,
      message: res.statusMessage,
      data: res.data?.article,
    );
  }

  @override
  Future<BaseResponseModel<Article>> unFavoriteArticle(String slug) async {
    final res = await AppApi.instance.swaggerApi((api) async {
      return await api.getFavoritesApi().deleteArticleFavorite(
            slug: slug,
          );
    });
    return BaseResponseModel(
      code: res.statusCode ?? 500,
      message: res.statusMessage,
      data: res.data?.article,
    );
  }
}
