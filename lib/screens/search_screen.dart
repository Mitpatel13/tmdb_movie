import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // When the user scrolls to the end of the list, fetch more movies
      final query = _controller.text;
      if (query.isNotEmpty) {
        final movieBloc = BlocProvider.of<MovieBloc>(context);
        if (!movieBloc.isLoadingMore) {
          movieBloc.currentPage++;
          movieBloc.add(SearchMovies(query, page: movieBloc.currentPage));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Movies...',
                  prefixIcon: Icon(Icons.search),
                  suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _controller.clear();
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(Icons.close, color: Colors.black, size: 12),
                        ),
                      ),
                    ),
                  ),
                ),
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    BlocProvider.of<MovieBloc>(context).add(SearchMovies(query));
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading && BlocProvider.of<MovieBloc>(context).currentPage == 1) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(movieId: state.movies[index].id),
                            ),
                          );
                        },
                        child: ListTile(
                          subtitle: Text(state.movies[index].releaseYear),
                          title: Text(state.movies[index].title),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      );
                    },
                    itemCount: state.movies.length,
                    shrinkWrap: true,
                  );
                } else if (state is MovieError) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return Container();
              },
            ),
          ),
          if (BlocProvider.of<MovieBloc>(context).isLoadingMore)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
