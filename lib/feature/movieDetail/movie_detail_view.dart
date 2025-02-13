import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/base/view/base_view.dart';
import 'package:the_movie_app/core/constants/app_constants.dart';
import 'package:the_movie_app/core/constants/text_constants.dart';
import 'package:the_movie_app/feature/movieDetail/components/movie_detail_content.dart';
import 'package:the_movie_app/feature/movieDetail/viewModel/movie_detail_view_model.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({required this.movieId, super.key});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return IBaseView<MovieDetailViewModel>(
      viewModel: MovieDetailViewModel()..fetchMovieDetail(movieId),
      builder: (context, viewModel) {
        final movie = viewModel.movieDetail;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(TextConstants.movieDetails),
          ),
          // extendBodyBehindAppBar: true,
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : movie == null
                  ? const Center(child: Text(TextConstants.errorMessage))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 350,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppConstants.radiusM),
                              child: CachedNetworkImage(
                                imageUrl: AppConstants.imageBaseUrl + movie.posterPath!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          MovieDetailContent(movie: movie),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
