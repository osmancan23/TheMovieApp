import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants/padding_constants.dart';
import 'package:the_movie_app/core/constants/text_constants.dart';
import 'package:the_movie_app/core/models/movie_detail_model.dart';
import 'package:the_movie_app/core/utils/animation_helper.dart';
import 'package:the_movie_app/utils/extensions/string_extensions.dart';

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    required this.movie,
    super.key,
  });

  final MovieDetailModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PaddingConstants.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimationHelper.slideInTransition(
            child: Text(
              movie.title ?? '',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: PaddingConstants.medium),
          if (movie.voteAverage != null) ...[
            AnimationHelper.slideInTransition(
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: PaddingConstants.medium),
                  Text(
                    movie.voteAverage!.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: PaddingConstants.medium),
                  Text(
                    '(${movie.voteCount} ${TextConstants.rating})',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
          if (movie.releaseDate != null) ...[
            const SizedBox(height: PaddingConstants.medium),
            AnimationHelper.slideInTransition(
              child: Text(
                '${TextConstants.releaseDate}: ${movie.releaseDate!.toDDMMYYYY()}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
          if (movie.overview != null) ...[
            const SizedBox(height: PaddingConstants.large),
            AnimationHelper.slideInTransition(
              child: Text(
                TextConstants.overview,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: PaddingConstants.small),
            AnimationHelper.fadeInTransition(
              child: Text(
                movie.overview!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
