import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class HomeState extends Equatable {
  final ELoadingStatus status;
  final List<Article> articles;
  final int page;
  final String? message;

  const HomeState({
    required this.status,
    required this.articles,
    required this.page,
    this.message,
  });

  const HomeState.init()
      : status = ELoadingStatus.init,
        articles = const <Article>[],
        page = 0,
        message = null;

  HomeState copyWith({
    ELoadingStatus? status,
    List<Article>? articles,
    int? page,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      page: page ?? this.page,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        articles,
        page,
        message,
      ];
}
