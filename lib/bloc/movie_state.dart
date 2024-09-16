import 'package:equatable/equatable.dart';
import '../models/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieError extends MovieState {
  final String error;

  const MovieError(this.error);

  @override
  List<Object> get props => [error];
}