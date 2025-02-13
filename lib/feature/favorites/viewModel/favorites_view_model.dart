import 'dart:developer';

import 'package:the_movie_app/core/base/viewModel/base_view_model.dart';
import 'package:the_movie_app/core/init/cache/cache_manager.dart';
import 'package:the_movie_app/core/init/network/network_manager.dart';
import 'package:the_movie_app/core/models/movie_model.dart';
import 'package:the_movie_app/core/service/movie_service.dart';

class FavoritesViewModel extends IBaseViewModel {
  late final IMovieService _movieService;
  List<MovieModel> _favoriteMovies = [];
  List<MovieModel> get favoriteMovies => _favoriteMovies;

  set favoriteMovies(List<MovieModel> value) {
    _favoriteMovies = value;
    notifyListeners();
  }

  @override
  void onInit() {
    _movieService = MovieService(networkManager: NetworkManager.instance);
    _loadFavoriteMovies();
    super.onInit();
  }

  Future<void> _loadFavoriteMovies() async {
    try {
      isLoading = true;
      final favoriteIds = CacheManager.getFavoriteMovies();
      final movies = <MovieModel>[];

      for (final id in favoriteIds) {
        final movieDetail = await _movieService.fetchMovieDetail(movieId: id);
        if (movieDetail != null) {
          movies.add(
            MovieModel(
              id: movieDetail.id,
              title: movieDetail.title,
              posterPath: movieDetail.posterPath,
              voteAverage: movieDetail.voteAverage,
              overview: movieDetail.overview,
            ),
          );
        }
      }

      favoriteMovies = movies;
    } catch (e) {
      log('Error: $e');
      // showError(context!, 'Favoriler yüklenirken bir hata oluştu');
    } finally {
      isLoading = false;
    }
  }

  Future<void> toggleFavorite(MovieModel movie) async {
    try {
      final movieId = movie.id ?? 0;
      if (CacheManager.isMovieFavorite(movieId)) {
        await CacheManager.removeFavoriteMovie(movieId);
        _favoriteMovies.removeWhere((element) => element.id == movieId);
      } else {
        await CacheManager.addFavoriteMovie(movieId);
        _favoriteMovies.add(movie);
      }
      notifyListeners();
    } catch (e) {
      showError(context!, 'Favori işlemi sırasında bir hata oluştu');
    }
  }
}
