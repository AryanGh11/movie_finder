class Intro {
  final int id;
  final String key;
  final String text;
  final String posterPath;

  Intro({
    required this.id,
    required this.key,
    required this.text,
    required this.posterPath,
  });

  factory Intro.fromJson(Map<String, dynamic> json) {
    return Intro(
      id: json["id"],
      key: json["key"],
      text: json["text"],
      posterPath: json["posterPath"],
    );
  }
}
