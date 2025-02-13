import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants/app_constants.dart';
import 'package:the_movie_app/core/init/network/network_manager.dart';
import 'package:the_movie_app/core/models/movie_detail_model.dart';
import 'package:the_movie_app/core/models/movie_model.dart';
import 'package:the_movie_app/core/models/movie_response_list_model.dart';

/// Abstract class defining the movie service interface
abstract class IMovieService {
  /// Constructor requiring a network manager instance
  IMovieService({required NetworkManager networkManager}) : _networkManager = networkManager;

  final NetworkManager _networkManager;

  /// Fetches trending movies from the API
  /// Returns a list of [MovieModel] or null if the request fails
  Future<List<MovieModel>?> fetchTrendingMovies();

  /// Searches for movies based on the provided query
  /// [query] - The search term to look for
  /// Returns a list of [MovieModel] matching the search query
  Future<List<MovieModel>> searchMovies({required String query});

  /// Fetches detailed information about a specific movie
  /// [movieId] - The ID of the movie to fetch details for
  /// Returns a [MovieDetailModel] or null if the request fails
  Future<MovieDetailModel?> fetchMovieDetail({required int movieId});
}

/// Implementation of the movie service interface
class MovieService extends IMovieService {
  /// Constructor requiring a network manager instance
  MovieService({required super.networkManager});

  @override
  Future<MovieDetailModel?> fetchMovieDetail({required int movieId}) async {
    try {
      final response = await _networkManager.send<MovieDetailModel, MovieDetailModel>(
        path: '${AppConstants.movieDetailsEndpoint}/$movieId',
        type: RequestType.get,
        parseModel: MovieDetailModel(),
      );

      return response;
    } catch (e) {
      debugPrint('Error fetching movie detail: $e');
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>?> fetchTrendingMovies() async {
    try {
      final response = await _networkManager.send<MovieResponseListModel, MovieResponseListModel>(
        path: AppConstants.trendingMoviesEndpoint,
        type: RequestType.get,
        parseModel: MovieResponseListModel(),
      );

      return response?.results ?? [];
    } catch (e) {
      debugPrint('Error fetching trending movies: $e');
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> searchMovies({required String query}) async {
    try {
      final response = await _networkManager.send<MovieResponseListModel, MovieResponseListModel>(
        path: AppConstants.searchMoviesEndpoint,
        type: RequestType.get,
        parseModel: MovieResponseListModel(),
        queryParameters: {'query': query},
      );

      return response?.results ?? [];
    } catch (e) {
      debugPrint('Error searching movies: $e');
      rethrow;
    }
  }
}
