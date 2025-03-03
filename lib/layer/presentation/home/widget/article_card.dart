import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size16,
        vertical: Sizes.size10,
      ),
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
    );
  }
}
