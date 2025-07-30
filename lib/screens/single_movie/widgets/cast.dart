import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/screens/single_movie/widgets/index.dart';
import 'package:movie_finder/widgets/index.dart';

class SingleMovieScreenCast extends StatelessWidget {
  final List<Cast> cast;

  const SingleMovieScreenCast({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return SingleMovieScreenHorizontalScrollableBox(
      title: null,
      items: cast,
      itemBuilder: (cast) => MovieCastCard(cast: cast),
      itemWidthRatio: 0.3,
    );
  }
}
