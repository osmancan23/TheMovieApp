import 'dart:async';
import 'package:flutter/material.dart';
import 'package:the_movie_app/core/base/viewModel/base_view_model.dart';
import 'package:the_movie_app/core/constants/text_constants.dart';
import 'package:the_movie_app/core/init/cache/cache_manager.dart';
import 'package:the_movie_app/core/init/navigation/navigation_service.dart';
import 'package:the_movie_app/core/init/network/network_manager.dart';
import 'package:the_movie_app/core/models/movie_model.dart';
import 'package:the_movie_app/core/service/movie_service.dart';
import 'package:the_movie_app/feature/favorites/favorites_view.dart';

/// ViewModel for the home screen
/// Handles movie list, search functionality, and favorites
class HomeViewModel extends IBaseViewModel {
  late final IMovieService _movieService;
  Timer? _debounceTimer;

  /// List of movies currently displayed
  List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  set movies(List<MovieModel> value) {
    _movies = value;
    notifyListeners();
  }

  /// Current search query
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  /// Handles search query changes with debouncing
  /// [value] - The new search query
  void onSearchQueryChanged(String value) {
    if (_searchQuery == value) return;
    _searchQuery = value;
    _debounceSearch();
  }

  @override
  void onInit() {
    _movieService = MovieService(networkManager: NetworkManager.instance);
    _fetchTrendingMovies();
    super.onInit();
  }

  /// Fetches trending movies from the API
  Future<void> _fetchTrendingMovies() async {
    try {
      isLoading = true;
      movies = await _movieService.fetchTrendingMovies() ?? [];
    } catch (e) {
      showError(context!, TextConstants.errorLoadingTrending);
    } finally {
      isLoading = false;
    }
  }

  /// Debounces search to prevent too many API calls
  void _debounceSearch() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_searchQuery.length >= 2) {
        _searchMovies();
      } else if (_searchQuery.isEmpty) {
        _fetchTrendingMovies();
      }
    });
  }

  /// Searches movies based on the current query
  Future<void> _searchMovies() async {
    try {
      isLoading = true;
      movies = await _movieService.searchMovies(query: _searchQuery);
    } catch (e) {
      showError(context!, TextConstants.errorSearching);
    } finally {
      isLoading = false;
    }
  }

  /// Toggles favorite status for a movie
  /// [movie] - The movie to toggle favorite status for
  Future<void> toggleFavorite(MovieModel movie) async {
    try {
      final movieId = movie.id ?? 0;
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

  /// Navigates to the favorites screen
  /// [context] - The build context
  void navigateToFavorites(BuildContext context) {
    NavigationService().navigateToPage(
      context: context,
      page: const FavoritesView(),
    );
  }

  @override
  void onDispose() {
    _debounceTimer?.cancel();
    super.onDispose();
  }
}
