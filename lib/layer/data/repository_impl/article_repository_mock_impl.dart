import 'package:flutter_bloc_clean_architecture/core/constant/app_consts.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class ArticleRepositoryMockImpl extends ArticleRepository {
  final int? errorCode;
  final int delayms;

  ArticleRepositoryMockImpl({
    this.errorCode,
    this.delayms = 1000,
  });

  @override
  Future<BaseResponseModel<List<Article>>> getArticles({
    String? tag,
    String? author,
    String? favorited,
    required int limit,
    required int offset,
  }) async {
    await Future.delayed(Duration(milliseconds: delayms));

    if (errorCode != null) {
      return BaseResponseModel(code: errorCode!, message: '$errorCode-error');
    }

    if (offset == 3) return BaseResponseModel(code: 200, data: []);
    return BaseResponseModel(
      code: 200,
      data: [
        for (var idx = limit * offset; idx < limit * (offset + 1); idx++)
          Article(
            author: Profile(
              username: '$idx author',
              following: idx % 2 == 0,
            ),
            slug: '$idx-slug',
            title: 'title $idx',
            description: 'description $idx',
            // body: 'body $idx'
            tagList: [
              '$idx tag 1',
              '$idx tag 2',
            ],
            favorited: idx % 2 == 0,
            favoritesCount: idx,
            createdAt: AppConsts.dateNow,
            updatedAt: AppConsts.dateNow,
          ),
      ],
    );
  }

  @override
  Future<BaseResponseModel<Article>> getArticle(String slug) async {
    await Future.delayed(Duration(milliseconds: delayms));

    if (errorCode != null) {
      return BaseResponseModel(code: errorCode!, message: '$errorCode-error');
    }

    final idx = int.parse(slug.split('-').first);
    return BaseResponseModel(
      code: 200,
      data: Article(
        author: Profile(
          username: '$idx author',
          following: idx % 2 == 0,
        ),
        slug: '$idx-slug',
        title: 'title $idx',
        description: 'description $idx',
        body: 'body $idx',
        tagList: [
          '$idx tag 1',
          '$idx tag 2',
        ],
        favorited: idx % 2 == 0,
        favoritesCount: idx,
        createdAt: AppConsts.dateNow,
        updatedAt: AppConsts.dateNow,
      ),
    );
  }

  @override
  Future<BaseResponseModel<Article>> favoriteArticle(String slug) async {
    await Future.delayed(Duration(milliseconds: delayms));

    if (errorCode != null) {
      return BaseResponseModel(code: errorCode!, message: '$errorCode-error');
    }

    final idx = int.parse(slug.split('-').first);
    return BaseResponseModel(
      code: 200,
      data: Article(
        author: Profile(
          username: '$idx author',
          following: idx % 2 == 0,
        ),
        slug: '$idx-slug',
        title: 'title $idx',
        description: 'description $idx',
        body: 'body $idx',
        tagList: [
          '$idx tag 1',
          '$idx tag 2',
        ],
        favorited: true,
        favoritesCount: idx,
        createdAt: AppConsts.dateNow,
        updatedAt: AppConsts.dateNow.add(Duration(seconds: 1)),
      ),
    );
  }

  @override
  Future<BaseResponseModel<Article>> unFavoriteArticle(String slug) async {
    await Future.delayed(Duration(milliseconds: delayms));

    if (errorCode != null) {
      return BaseResponseModel(code: errorCode!, message: '$errorCode-error');
    }

    final idx = int.parse(slug.split('-').first);
    return BaseResponseModel(
      code: 200,
      data: Article(
        author: Profile(
          username: '$idx author',
          following: idx % 2 == 0,
        ),
        slug: '$idx-slug',
        title: 'title $idx',
        description: 'description $idx',
        body: 'body $idx',
        tagList: [
          '$idx tag 1',
          '$idx tag 2',
        ],
        favorited: false,
        favoritesCount: idx,
        createdAt: AppConsts.dateNow,
        updatedAt: AppConsts.dateNow.add(Duration(seconds: 1)),
      ),
    );
  }
}
