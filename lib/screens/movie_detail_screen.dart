import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie.dart';
import '../repository/movie_repositor.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<Movie> _movieDetails;

  @override
  void initState() {
    super.initState();
    _movieDetails = MovieRepository().fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: TextStyle(color: Colors.blueAccent, fontSize: 15),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.blueAccent, size: 15),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Movie>(
        future: _movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Movie movie = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  CachedNetworkImage(
                    imageUrl: movie.fullPosterPath,
                    height: 250,
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${movie.genres.map((genre) => genre.name).join(", ")}'
                        ' • ${movie.releaseDate.split('-')[0]} • ${movie.runtime} min',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 10),

                  Text(
                    movie.overview,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Row(
                        children: List.generate(movie.rating.toInt(), (index) {
                          return Icon(Icons.star, color: Colors.amber);
                        }),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${movie.rating.toInt()}/10',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildDetailSection("Starring", [
                          "Robert Downey Jr.",
                          "Chris Evans",
                          "Mark Ruffalo",
                          "Scarlett Johansson",
                        ]),
                      ),
                      SizedBox(width: 20), // Add spacing between columns
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start, // Align to right
                          children: [
                            _buildDetailSection("Director", ["Joss Whedon"]),
                            _buildDetailSection("Producer", ["Kevin Feige"]),
                            _buildDetailSection("Screenwriter", ["Joss Whedon"]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("No data found."));
          }
        },
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...details.map((detail) => Text(detail)).toList(),
        ],
      ),
    );
  }
}
