part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class FavoriteInitStreamEvent extends FavoriteEvent {}

class FavoriteFavorEvent extends FavoriteEvent {
  final Article article;

  FavoriteFavorEvent({required this.article});
}

class FavoriteUnfavorEvent extends FavoriteEvent {
  final Article article;

  FavoriteUnfavorEvent({required this.article});
}
