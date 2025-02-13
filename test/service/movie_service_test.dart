import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_app/core/init/network/network_manager.dart';
import 'package:the_movie_app/core/service/movie_service.dart';

void main() {
  late IMovieService movieService;
  setUp(() {
    movieService = MovieService(networkManager: NetworkManager.instance);
  });
  test('Sample Test', () async {
    final response = await movieService.fetchTrendingMovies();

    // debugPrint('response: $response');

    expect(response, isNotNull);
  });

  test('Sample Test', () async {
    final response = await movieService.fetchMovieDetail(movieId: 278);

    debugPrint('response: ${response?.title}');
    expect(response, isNotNull);
  });

  test('Sample Test', () async {
    final response = await movieService.searchMovies(query: 'batman');

    print('response: ${response.first.title}');

    expect(response, isNotNull);
  });
}
