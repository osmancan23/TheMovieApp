import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants/app_constants.dart';
import 'package:the_movie_app/core/constants/padding_constants.dart';
import 'package:the_movie_app/core/init/navigation/navigation_service.dart';
import 'package:the_movie_app/core/models/movie_model.dart';
import 'package:the_movie_app/core/utils/animation_helper.dart';
import 'package:the_movie_app/feature/movieDetail/movie_detail_view.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    required this.movie,
    this.onFavoritePressed,
    this.isFavorite = false,
    super.key,
  });

  final MovieModel movie;
  final VoidCallback? onFavoritePressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return AnimationHelper.scaleInTransition(
      child: GestureDetector(
        onTap: () {
          NavigationService().navigateToPage(
            context: context,
            page: MovieDetailView(movieId: movie.id ?? 0),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            child: Stack(
              children: [
                // Poster Image
                Positioned.fill(
                  child: Hero(
                    tag: 'movie_${movie.id}',
                    child: CachedNetworkImage(
                      imageUrl: '${AppConstants.imageBaseUrl}${movie.posterPath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Movie Title
                Positioned(
                  bottom: PaddingConstants.medium,
                  left: PaddingConstants.small,
                  right: PaddingConstants.small,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (movie.voteAverage != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.voteAverage!.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // Favorite Button
                if (onFavoritePressed != null)
                  Positioned(
                    top: PaddingConstants.small,
                    right: PaddingConstants.small,
                    child: AnimationHelper.scaleInTransition(
                      duration: AppConstants.animationFast,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(AppConstants.radiusS),
                        ),
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: onFavoritePressed,
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          padding: const EdgeInsets.all(4),
                          iconSize: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
