import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants/padding_constants.dart';
import 'package:the_movie_app/core/constants/text_constants.dart';
import 'package:the_movie_app/core/models/movie_model.dart';
import 'package:the_movie_app/core/utils/animation_helper.dart';
import 'package:the_movie_app/feature/home/components/movieCard/movie_card_widget.dart';

class MovieGridView extends StatelessWidget {
  const MovieGridView({
    required this.movies,
    required this.onFavoritePressed,
    required this.isMovieFavorite,
    this.isLoading = false,
    this.searchQuery = '',
    super.key,
  });

  final List<MovieModel> movies;
  final bool isLoading;
  final String searchQuery;
  final Future<void> Function(MovieModel movie) onFavoritePressed;
  final bool Function(int movieId) isMovieFavorite;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (movies.isEmpty) {
      return Center(
        child: Text(
          searchQuery.isEmpty ? TextConstants.noResults : TextConstants.noResults,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return AnimationHelper.fadeInTransition(
      child: GridView.builder(
        padding: const EdgeInsets.all(PaddingConstants.medium),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: PaddingConstants.medium,
          crossAxisSpacing: PaddingConstants.medium,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCardWidget(
            movie: movie,
            isFavorite: isMovieFavorite(movie.id ?? 0),
            onFavoritePressed: () => onFavoritePressed(movie),
          );
        },
      ),
    );
  }
}
