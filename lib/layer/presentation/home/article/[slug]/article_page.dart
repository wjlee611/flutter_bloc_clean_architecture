import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/article/%5Bslug%5D/bloc/article_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/article/%5Bslug%5D/bloc/article_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticleHydratedState) {
              return Text('Article - hydrated');
            }
            return Text('Article');
          },
        ),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          switch (state) {
            case ArticleInitState():
              if (state.article != null) {
                return _article(state.article!);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            case ArticleHydratedState():
              return _article(state.article);
            case ArticleErrorState():
              return Center(
                child: Text(state.message),
              );
          }
        },
      ),
    );
  }

  Widget _article(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(article.title),
          Text(article.description),
          Text(article.body ?? '')
        ],
      ),
    );
  }
}
