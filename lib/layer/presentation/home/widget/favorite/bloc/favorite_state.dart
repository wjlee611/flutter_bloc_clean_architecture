import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';

sealed class FavoriteState extends Equatable {
  final ELoadingStatus status;

  const FavoriteState({required this.status});
}

class FavoriteFavorState extends FavoriteState {
  const FavoriteFavorState({required super.status});

  @override
  List<Object?> get props => [status];
}

class FavoriteUnfavorState extends FavoriteState {
  const FavoriteUnfavorState({required super.status});

  @override
  List<Object?> get props => [status];
}
