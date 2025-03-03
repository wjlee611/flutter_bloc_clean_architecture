import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';
import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/widget/favorite/favorite_button.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
import 'package:go_router/go_router.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final Function()? buildCallback;

  const ArticleCard({
    super.key,
    required this.article,
    this.buildCallback,
  });

  @override
  Widget build(BuildContext context) {
    buildCallback?.call();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.push(
          '${AppRouter.home}/${AppRouter.homeSubArticle}/${article.slug}',
          extra: article,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16,
          vertical: Sizes.size10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(article.description),
                ],
              ),
            ),
            FavoriteButton(article: article),
          ],
        ),
      ),
    );
  }
}
