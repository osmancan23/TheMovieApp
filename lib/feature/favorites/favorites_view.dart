import 'package:flutter/material.dart';
import 'package:the_movie_app/core/base/view/base_view.dart';
import 'package:the_movie_app/core/constants/padding_constants.dart';
import 'package:the_movie_app/core/constants/text_constants.dart';
import 'package:the_movie_app/core/utils/animation_helper.dart';
import 'package:the_movie_app/feature/favorites/viewModel/favorites_view_model.dart';
import 'package:the_movie_app/feature/home/components/movieCard/movie_card_widget.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return IBaseView<FavoritesViewModel>(
      viewModel: FavoritesViewModel(),
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(TextConstants.favorites),
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.favoriteMovies.isEmpty
                  ? Center(
                      child: AnimationHelper.fadeInTransition(
                        child: Text(
                          TextConstants.noFavorites,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : AnimationHelper.fadeInTransition(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(PaddingConstants.gridSpacing),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: PaddingConstants.gridSpacing,
                          crossAxisSpacing: PaddingConstants.gridSpacing,
                        ),
                        itemCount: viewModel.favoriteMovies.length,
                        itemBuilder: (context, index) {
                          final movie = viewModel.favoriteMovies[index];
                          return MovieCardWidget(
                            movie: movie,
                            isFavorite: true,
                            onFavoritePressed: () {
                              viewModel.toggleFavorite(movie);
                            },
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}
