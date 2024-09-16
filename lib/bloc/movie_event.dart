import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchNowPlayingMovies extends MovieEvent {
  final int page;

  FetchNowPlayingMovies({this.page = 1}); // Add page parameter

  @override
  List<Object> get props => [page];
}

class FetchPopularMovies extends MovieEvent {
  final int page;

  FetchPopularMovies({this.page = 1});

  @override
  List<Object> get props => [page];
}

class FetchTopRatedMovies extends MovieEvent {
  final int page;

  FetchTopRatedMovies({this.page = 1});

  @override
  List<Object> get props => [page];
}

class FetchUpcomingMovies extends MovieEvent {
  final int page;

  FetchUpcomingMovies({this.page = 1});

  @override
  List<Object> get props => [page];
}

class SearchMovies extends MovieEvent {
  final String query;
  final int page;

  SearchMovies(this.query, {this.page = 1});  // Add page parameter with default value 1

  @override
  List<Object?> get props => [query, page];
}