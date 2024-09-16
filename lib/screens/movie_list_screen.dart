import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../widgets/movie_grid.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The MovieDb',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMovieSection(
                context: context,
                title: "Now Playing",
                event: FetchNowPlayingMovies(),
              ),
              _buildMovieSection(
                context: context,
                title: "Popular",
                event: FetchPopularMovies(),
              ),
              _buildMovieSection(
                context: context,
                title: "Top Rated",
                event: FetchTopRatedMovies(),
              ),
              _buildMovieSection(
                context: context,
                title: "Upcoming",
                event: FetchUpcomingMovies(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieSection({
    required BuildContext context,
    required String title,
    required MovieEvent event,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        BlocProvider(
          create: (_) => MovieBloc(RepositoryProvider.of(context))..add(event),
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieInitial) {
                return Center(child: Text('Loading movies...'));
              } else if (state is MovieLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MovieLoaded) {
                return MovieGrid(movies: state.movies);
              } else if (state is MovieError) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
