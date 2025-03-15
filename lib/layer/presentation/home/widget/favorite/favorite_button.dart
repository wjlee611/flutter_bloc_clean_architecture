import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/widget/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/widget/favorite/bloc/favorite_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class FavoriteButton extends StatelessWidget {
  final Article article;

  const FavoriteButton({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(
        article: article,
        toggleFavorite: context.read<ToggleFavorite>(),
      ),
      child: Builder(
        builder: (context) => BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                if (state is FavoriteFavorState) {
                  context.read<FavoriteBloc>().add(FavoriteUnfavorEvent());
                } else {
                  context.read<FavoriteBloc>().add(FavoriteFavorEvent());
                }
              },
              icon: state is FavoriteFavorState
                  ? Icon(
                      key: Key('${article.slug}-favor'),
                      Icons.favorite,
                    )
                  : Icon(
                      key: Key('${article.slug}-unfavor'),
                      Icons.favorite_border,
                    ),
            );
          },
        ),
      ),
    );
  }
}
