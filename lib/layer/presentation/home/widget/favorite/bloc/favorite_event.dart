part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class FavoriteInitStreamEvent extends FavoriteEvent {}

class FavoriteFavorEvent extends FavoriteEvent {}

class FavoriteUnfavorEvent extends FavoriteEvent {}
