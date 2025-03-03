import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

sealed class ArticleState extends Equatable {
  final String slug;

  const ArticleState({
    required this.slug,
  });
}

class ArticleInitState extends ArticleState {
  final Article? article;

  const ArticleInitState({
    required super.slug,
    this.article,
  });

  @override
  List<Object?> get props => [
        slug,
        article,
      ];
}

class ArticleHydratedState extends ArticleState {
  final Article article;

  const ArticleHydratedState({
    required super.slug,
    required this.article,
  });

  @override
  List<Object?> get props => [
        slug,
        article,
      ];
}

class ArticleErrorState extends ArticleState {
  final String message;

  const ArticleErrorState({
    required super.slug,
    required this.message,
  });

  @override
  List<Object?> get props => [
        slug,
        message,
      ];
}
