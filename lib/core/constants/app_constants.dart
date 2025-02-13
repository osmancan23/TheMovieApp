/// Contains all application-wide constants
class AppConstants {
  /// API Key for TMDB
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYjJhOWNkMmEzMWNjYWQ5OWY0MzdmNjY0N2Q2ZTlkZiIsIm5iZiI6MTY4NDE4MTUyOS43NDU5OTk4LCJzdWIiOiI2NDYyOTIxOWUzZmEyZjAwZTQwNDQ3Y2IiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.QhkUS4iZDVrZl2wfel0nJenFBpEau9s9MZ1Boq34LIA';

  /// Base URL for TMDB API
  static const String baseUrl = 'https://api.themoviedb.org';

  /// Base URL for TMDB images
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w220_and_h330_face';

  // Border Radius Constants
  /// Small border radius - 8.0
  static const double radiusS = 8;

  /// Medium border radius - 12.0
  static const double radiusM = 12;

  /// Large border radius - 16.0
  static const double radiusL = 16;

  // Animation Duration Constants
  /// Fast animation duration - 300ms
  static const Duration animationFast = Duration(milliseconds: 300);

  /// Normal animation duration - 500ms
  static const Duration animationNormal = Duration(milliseconds: 500);

  /// Slow animation duration - 800ms
  static const Duration animationSlow = Duration(milliseconds: 800);

  // API Endpoints
  /// Endpoint for trending movies
  static const String trendingMoviesEndpoint = '/3/movie/top_rated';

  /// Endpoint for movie search
  static const String searchMoviesEndpoint = '/3/search/movie';

  /// Endpoint for movie details
  static const String movieDetailsEndpoint = '/3/movie';
}
