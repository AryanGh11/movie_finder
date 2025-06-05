import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final int _id;

  @HiveField(1)
  final String _title;

  @HiveField(2)
  final String _overview;

  @HiveField(3)
  final String? _posterPath;

  @HiveField(4)
  final double? _voteAverage;

  @HiveField(5)
  final bool? _adult;

  @HiveField(6)
  final String? _originalLanguage;

  @HiveField(7)
  final double? _popularity;

  @HiveField(8)
  final String? _releaseDate;

  @HiveField(9)
  final int? _voteCount;

  @HiveField(10)
  final List<String>? _originCountries;

  @HiveField(11)
  final int? _budget;

  @HiveField(12)
  final List<Map<dynamic, dynamic>>? _genres;

  @HiveField(13)
  final List<Map<dynamic, dynamic>>? _productionCompanies;

  @HiveField(14)
  final List<Map<dynamic, dynamic>>? _productionCountries;

  @HiveField(15)
  final String? _homepage;

  @HiveField(16)
  final int? _revenue;

  @HiveField(17)
  final int? _duration;

  @HiveField(18)
  final List<Map<dynamic, dynamic>>? _spokenLanguages;

  @HiveField(19)
  final String? _status;

  @HiveField(20)
  final String? _tagline;

  @HiveField(21)
  final String? _imdbId;

  Movie({
    required int id,
    required String title,
    required String overview,
    String? posterPath,
    double? voteAverage,
    bool? adult,
    int? budget,
    List<Map<dynamic, dynamic>>? genres,
    String? homepage,
    String? imdbId,
    List<String>? originCountries,
    String? originalLanguage,
    double? popularity,
    List<Map<dynamic, dynamic>>? productionCompanies,
    List<Map<dynamic, dynamic>>? productionCountries,
    String? releaseDate,
    int? revenue,
    int? duration,
    List<Map<dynamic, dynamic>>? spokenLanguages,
    String? status,
    String? tagline,
    int? voteCount,
  }) : _id = id,
       _title = title,
       _overview = overview,
       _posterPath = posterPath,
       _voteAverage = voteAverage,
       _adult = adult,
       _budget = budget,
       _genres = genres,
       _homepage = homepage,
       _imdbId = imdbId,
       _originCountries = originCountries,
       _originalLanguage = originalLanguage,
       _popularity = popularity,
       _productionCompanies = productionCompanies,
       _productionCountries = productionCountries,
       _releaseDate = releaseDate,
       _revenue = revenue,
       _duration = duration,
       _spokenLanguages = spokenLanguages,
       _status = status,
       _tagline = tagline,
       _voteCount = voteCount;

  factory Movie.fromSummary(Map<dynamic, dynamic> json) => Movie(
    id: json["id"],
    title: json["title"] ?? "",
    overview: json["overview"] ?? "",
    posterPath: json["poster_path"],
    voteAverage: (json["vote_average"] as num?)?.toDouble(),
    adult: json["adult"],
    originalLanguage: json["original_language"],
    popularity: (json["popularity"] as num?)?.toDouble(),
    releaseDate: json["release_date"],
    voteCount: json["vote_count"],
  );

  factory Movie.fromDetailed(Map<dynamic, dynamic> json) => Movie(
    id: json["id"],
    title: json["title"] ?? "",
    overview: json["overview"] ?? "",
    posterPath: json["poster_path"],
    voteAverage: (json["vote_average"] as num?)?.toDouble(),
    adult: json["adult"],
    originalLanguage: json["original_language"],
    popularity: (json["popularity"] as num?)?.toDouble(),
    releaseDate: json["release_date"],
    voteCount: json["vote_count"],
    budget: json["budget"],
    genres: List<Map<dynamic, dynamic>>.from(json["genres"] ?? []),
    homepage: json["homepage"],
    imdbId: json["imdb_id"],
    originCountries: List<String>.from(json["origin_country"] ?? []),
    productionCompanies: List<Map<dynamic, dynamic>>.from(
      json["production_companies"] ?? [],
    ),
    productionCountries: List<Map<dynamic, dynamic>>.from(
      json["production_countries"] ?? [],
    ),
    revenue: json["revenue"],
    duration: json["runtime"],
    spokenLanguages: List<Map<dynamic, dynamic>>.from(
      (json["spoken_languages"] ?? []).map(
        (lang) => Map<dynamic, dynamic>.from(lang),
      ),
    ),
    status: json["status"],
    tagline: json["tagline"],
  );

  int get id => _id;

  String get title => _title;

  String get overview => _overview;

  String get posterPath => 'https://image.tmdb.org/t/p/original$_posterPath';

  double? get voteAverage => _voteAverage != null
      ? double.parse(_voteAverage.toStringAsFixed(1))
      : null;

  double? get ratingVoteAverage => voteAverage != null
      ? double.parse((voteAverage! / 2).toStringAsFixed(1))
      : null;

  bool? get adult => _adult;

  String? get originalLanguage => _originalLanguage;

  double? get popularity => _popularity;

  String? get releaseDate => _releaseDate;

  int? get releaseYear =>
      releaseDate != null ? int.parse(releaseDate!.split("-")[0]) : null;

  int? get voteCount => _voteCount;

  List<String>? get originCountries => _originCountries;

  int? get budget => _budget;

  List<Map<dynamic, dynamic>>? get genres => _genres;

  List<Map<dynamic, dynamic>>? get productionCompanies => _productionCompanies;

  List<Map<dynamic, dynamic>>? get productionCountries => _productionCountries;

  String? get homepage => _homepage;

  int? get revenue => _revenue;

  int? get duration => _duration;

  String? get formattedDuration {
    if (duration != null) {
      final int hours = (duration! / 60).floor();
      final int minutes = duration! % 60;

      if (hours == 0) return '${minutes}m';

      return '${(duration! / 60).floor()}h ${duration! % 60}m';
    }

    return null;
  }

  List<Map<dynamic, dynamic>>? get spokenLanguages => _spokenLanguages;

  String? get status => _status;

  String? get tagline => _tagline;

  String? get imdbId => _imdbId;
}
