import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/screens/single_cast/widgets/index.dart';

class SingleCastScreenMovies extends StatelessWidget {
  final List<Movie> movies;

  const SingleCastScreenMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SingleCastScreenHorizontalScrollableBox(
      title: null,
      items: movies,
      itemBuilder: (movie) => VerticalMovieCard(movie: movie),
      itemWidthRatio: 0.4,
    );
  }
}
