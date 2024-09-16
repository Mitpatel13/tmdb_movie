import 'package:dio/dio.dart';
import '../models/movie.dart';

class MovieRepository {
  final Dio _dio = Dio();
  final String _apiKey = 'b51d47bede4dd0a06234ca087566c41d';

  // Now Playing Movies
  Future<List<Movie>> fetchNowPlayingMovies(int page) async {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/movie/now_playing',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
        'page': page,
      },
    );
    return (response.data['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  }

  // Popular Movies
  Future<List<Movie>> fetchPopularMovies(int page) async {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/movie/popular',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
        'page': page,
      },
    );
    return (response.data['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  }

  // Top Rated Movies
  Future<List<Movie>> fetchTopRatedMovies(int page) async {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/movie/top_rated',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
        'page': page,
      },
    );
    return (response.data['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  }

  // Upcoming Movies
  Future<List<Movie>> fetchUpcomingMovies(int page) async {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/movie/upcoming',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
        'page': page,
      },
    );
    return (response.data['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  }

  // Search Movies
  Future<List<Movie>> searchMovies(String query, int page) async {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/search/movie',
      queryParameters: {
        'api_key': _apiKey,
        'query': query,
        'language': 'en-US',
        'page': page,
      },
    );
    return (response.data['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  }
  // Fetch Movie Detail
  Future<Movie> fetchMovieDetails(int movieId) async {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/movie/$movieId',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
      },
    );

    return Movie.fromJson(response.data);
  }
}
