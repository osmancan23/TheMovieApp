import 'package:the_movie_app/core/base/viewModel/base_view_model.dart';
import 'package:the_movie_app/core/constants/text_constants.dart';
import 'package:the_movie_app/core/init/cache/cache_manager.dart';
import 'package:the_movie_app/core/init/network/network_manager.dart';
import 'package:the_movie_app/core/models/movie_detail_model.dart';
import 'package:the_movie_app/core/service/movie_service.dart';

/// ViewModel for the movie detail screen
/// Handles movie details and favorite functionality
class MovieDetailViewModel extends IBaseViewModel {
  late final IMovieService _movieService;

  /// Current movie details
  MovieDetailModel? _movieDetail;
  MovieDetailModel? get movieDetail => _movieDetail;

  set movieDetail(MovieDetailModel? value) {
    _movieDetail = value;
    notifyListeners();
  }

  @override
  void onInit() {
    _movieService = MovieService(networkManager: NetworkManager.instance);
    super.onInit();
  }

  /// Fetches detailed information about a specific movie
  /// [movieId] - The ID of the movie to fetch details for
  Future<void> fetchMovieDetail(int movieId) async {
    try {
      isLoading = true;
      movieDetail = await _movieService.fetchMovieDetail(movieId: movieId);
    } catch (e) {
      showError(context!, TextConstants.errorLoadingDetails);
    } finally {
      isLoading = false;
    }
  }

  /// Toggles favorite status for the current movie
  /// [movieId] - The ID of the movie to toggle favorite status for
  Future<void> toggleFavorite(int movieId) async {
    try {
      if (CacheManager.isMovieFavorite(movieId)) {
        await CacheManager.removeFavoriteMovie(movieId);
      } else {
        await CacheManager.addFavoriteMovie(movieId);
      }
      notifyListeners();
    } catch (e) {
      showError(context!, TextConstants.errorFavoriteOperation);
    }
  }

  @override
  void onDispose() {
    movieDetail = null;
    super.onDispose();
  }
}
