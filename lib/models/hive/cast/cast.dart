import 'package:hive/hive.dart';
import 'package:movie_finder/models/index.dart';

part 'cast.g.dart';

@HiveType(typeId: 0)
class Cast {
  // Summary
  @HiveField(0)
  final int _id;

  @HiveField(1)
  final String _name;

  @HiveField(2)
  final int _gender;

  @HiveField(3)
  final String? _profilePath;

  @HiveField(4)
  final double? _popularity;

  @HiveField(5)
  final bool? _adult;

  @HiveField(6)
  final String? _character;

  @HiveField(7)
  final int? _order;

  // Detailed
  @HiveField(8)
  final String? _biography;

  @HiveField(9)
  final String? _birthday;

  @HiveField(10)
  final String? _deathday;

  @HiveField(11)
  final String? _imdbId;

  @HiveField(12)
  final String? _placeOfBirth;

  @HiveField(13)
  final List<Movie>? _movies;

  Cast({
    required int id,
    required String name,
    required int gender,
    String? profilePath,
    bool? adult,
    String? character,
    double? popularity,
    int? order,
    String? biography,
    String? birthday,
    String? deathday,
    String? imdbId,
    String? placeOfBirth,
    List<Movie>? movies,
  }) : _id = id,
       _name = name,
       _gender = gender,
       _profilePath = profilePath,
       _adult = adult,
       _character = character,
       _popularity = popularity,
       _order = order,
       _biography = biography,
       _birthday = birthday,
       _deathday = deathday,
       _imdbId = imdbId,
       _placeOfBirth = placeOfBirth,
       _movies = movies;

  factory Cast.fromSummary(Map<dynamic, dynamic> json) => Cast(
    id: json["id"],
    name: json["name"] ?? "",
    gender: json["gender"] ?? "",
    profilePath: json["profile_path"],
    adult: json["adult"],
    character: json["character"],
    popularity: (json["popularity"] as num?)?.toDouble(),
    order: json["order"],
  );

  factory Cast.fromDetailed(Map<dynamic, dynamic> json) => Cast(
    id: json["id"],
    name: json["name"] ?? "",
    gender: json["gender"] ?? "",
    profilePath: json["profile_path"],
    adult: json["adult"],
    character: json["character"],
    popularity: (json["popularity"] as num?)?.toDouble(),
    order: json["order"],
    biography: json["biography"],
    birthday: json["birthday"],
    deathday: json["deathday"],
    imdbId: json["imdb_id"],
    placeOfBirth: json["place_of_birth"],
    movies: (json["credits"]?["cast"] as List<dynamic>?)
        ?.map((e) => Movie.fromSummary(e))
        .toList(),
  );

  int get id => _id;

  String get name => _name;

  int get gender => _gender;

  String? get profilePath => _profilePath != null
      ? 'https://image.tmdb.org/t/p/original$_profilePath'
      : null;

  bool? get adult => _adult;

  String? get character => _character;

  double? get popularity => _popularity;

  int? get order => _order;

  String? get biography => _biography;

  DateTime? get birthday =>
      _birthday != null ? DateTime.tryParse(_birthday) : null;

  DateTime? get deathday =>
      _deathday != null ? DateTime.tryParse(_deathday) : null;

  String? get imdbId => _imdbId;

  String? get placeOfBirth => _placeOfBirth;

  List<Movie>? get movies => _movies;

  int? get age {
    final int thisYear = DateTime.now().year;
    final int? birthdayYear = birthday?.year;

    if (birthdayYear == null) return null;

    return thisYear - birthdayYear;
  }
}
