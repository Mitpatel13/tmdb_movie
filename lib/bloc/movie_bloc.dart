import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/movie_repositor.dart';
import '../models/movie.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;
  List<Movie> currentMovies = [];
  int currentPage = 1;
  bool isLoadingMore = false;

  MovieBloc(this.repository) : super(MovieInitial()) {  // Set MovieInitial as the initial state
    on<FetchNowPlayingMovies>(_fetchNowPlayingMovies);
    on<FetchPopularMovies>(_fetchPopularMovies);
    on<FetchTopRatedMovies>(_fetchTopRatedMovies);
    on<FetchUpcomingMovies>(_fetchUpcomingMovies);
    on<SearchMovies>(_onSearchMovies);

  }

  Future<void> _fetchNowPlayingMovies(FetchNowPlayingMovies event, Emitter<MovieState> emit) async {
    try {
      if (event.page == 1) emit(MovieLoading());
      final movies = await repository.fetchNowPlayingMovies(event.page);
      emit(MovieLoaded(movies: movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _fetchPopularMovies(FetchPopularMovies event, Emitter<MovieState> emit) async {
    try {
      if (event.page == 1) emit(MovieLoading());
      final movies = await repository.fetchPopularMovies(event.page);
      emit(MovieLoaded(movies: movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _fetchTopRatedMovies(FetchTopRatedMovies event, Emitter<MovieState> emit) async {
    try {
      if (event.page == 1) emit(MovieLoading());
      final movies = await repository.fetchTopRatedMovies(event.page);
      emit(MovieLoaded(movies: movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _fetchUpcomingMovies(FetchUpcomingMovies event, Emitter<MovieState> emit) async {
    try {
      if (event.page == 1) emit(MovieLoading());
      final movies = await repository.fetchUpcomingMovies(event.page);
      emit(MovieLoaded(movies: movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
  Future<void> _onSearchMovies(SearchMovies event, Emitter<MovieState> emit) async {
    try {
      if (event.page == 1) {
        emit(MovieLoading());
        currentMovies = [];
      }
      isLoadingMore = true;
      final movies = await repository.searchMovies(event.query, event.page);
      currentMovies = currentMovies + movies;
      emit(MovieLoaded(movies: currentMovies));
      isLoadingMore = false;
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

}
