class MovieImage {
  final int _id;
  final String? _backdropPath;
  final String? _posterPath;

  MovieImage({required id, required backdropPath, required posterPath})
    : _id = id,
      _backdropPath = backdropPath,
      _posterPath = posterPath;

  factory MovieImage.fromJson(Map<String, dynamic> json) {
    return MovieImage(
      id: json["id"],
      backdropPath: List.from(json["backdrops"])[0]?["file_path"],
      posterPath: List.from(json["posters"])[0]?["file_path"],
    );
  }

  int get id => _id;

  String get backdropPath =>
      'https://image.tmdb.org/t/p/original$_backdropPath';

  String get posterPath => 'https://image.tmdb.org/t/p/original$_posterPath';
}
