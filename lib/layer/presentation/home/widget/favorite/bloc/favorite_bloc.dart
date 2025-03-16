import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/widget/favorite/bloc/favorite_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
import 'package:flutter_bloc_clean_architecture/util/app_snackbar.dart';

part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final String _slug;
  final ToggleFavorite _toggleFavorite;

  FavoriteBloc({
    required Article article,
    required ToggleFavorite toggleFavorite,
  })  : _slug = article.slug,
        _toggleFavorite = toggleFavorite,
        super(article.favorited
            ? FavoriteFavorState(status: ELoadingStatus.init)
            : FavoriteUnfavorState(status: ELoadingStatus.init)) {
    on<FavoriteInitStreamEvent>(_favoriteInitStreamEventHandler);
    on<FavoriteFavorEvent>(_favoriteFavorEventHandler);
    on<FavoriteUnfavorEvent>(_favoriteUnfavorEventHandler);

    add(FavoriteInitStreamEvent());
  }

  Future<void> _favoriteInitStreamEventHandler(
    FavoriteInitStreamEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await emit.forEach(
      _toggleFavorite.stream,
      onData: (data) {
        if (data.code >= 300 && data.data?.slug == _slug) {
          appSnackbar(message: data.message ?? 'Unknown error');
        }
        if (data.data == null || data.data?.slug != _slug) return state;
        if (data.data!.favorited == true) {
          return FavoriteFavorState(
            status: data.code == 299 ? state.status : ELoadingStatus.loaded,
          );
        } else {
          return FavoriteUnfavorState(
            status: data.code == 299 ? state.status : ELoadingStatus.loaded,
          );
        }
      },
    );
  }

  Future<void> _favoriteFavorEventHandler(
    FavoriteFavorEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    emit(FavoriteUnfavorState(status: ELoadingStatus.loading));
    _toggleFavorite.call(article: event.article, toFavorite: true);
  }

  Future<void> _favoriteUnfavorEventHandler(
    FavoriteUnfavorEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    emit(FavoriteFavorState(status: ELoadingStatus.loading));
    _toggleFavorite.call(article: event.article, toFavorite: false);
  }
}
