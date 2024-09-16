class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double rating;
  final List<Genre> genres;
  final int runtime;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.rating,
    required this.genres,
    required this.runtime,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? 'No overview available',
      releaseDate: json['release_date'] ?? 'No release date available',
      rating: (json['vote_average'] ?? 0.0).toDouble(),
      genres: (json['genres'] as List?)
          ?.map((genreJson) => Genre.fromJson(genreJson))
          .toList() ?? [],
      runtime: json['runtime'] ?? 0,
    );
  }


  String get fullPosterPath => 'https://image.tmdb.org/t/p/w500/$posterPath';

  String get releaseYear {
    return releaseDate.isNotEmpty ? releaseDate.split('-')[0] : 'No Date Found';
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}


