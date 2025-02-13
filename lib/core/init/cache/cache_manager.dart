import 'package:hive_flutter/hive_flutter.dart';

class CacheManager {
  static const String _favoriteMoviesBoxName = 'favoriteMovies';
  static Box<List<dynamic>>? _favoritesBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _favoritesBox = await Hive.openBox<List<dynamic>>(_favoriteMoviesBoxName);
  }

  static Future<void> addFavoriteMovie(int movieId) async {
    final currentFavorites = getFavoriteMovies();
    if (!currentFavorites.contains(movieId)) {
      currentFavorites.add(movieId);
      await _favoritesBox?.put(_favoriteMoviesBoxName, currentFavorites);
    }
  }

  static Future<void> removeFavoriteMovie(int movieId) async {
    final currentFavorites = getFavoriteMovies();
    // ignore: cascade_invocations
    currentFavorites.remove(movieId);
    await _favoritesBox?.put(_favoriteMoviesBoxName, currentFavorites);
  }

  static List<int> getFavoriteMovies() {
    final favorites = _favoritesBox?.get(_favoriteMoviesBoxName, defaultValue: <int>[]);
    return List<int>.from(favorites ?? []);
  }

  static bool isMovieFavorite(int movieId) {
    return getFavoriteMovies().contains(movieId);
  }
}
