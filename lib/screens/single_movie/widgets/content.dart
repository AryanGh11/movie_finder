import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/screens/single_movie/widgets/index.dart';

class SingleMovieScreenContent extends StatelessWidget {
  final Movie movie;

  const SingleMovieScreenContent({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: [
                  SingleMovieScreenSubtitle(text: movie.formattedDuration),
                  SingleMovieScreenDotDivider(),
                  SingleMovieScreenSubtitle(text: movie.releaseYear.toString()),
                  SingleMovieScreenDotDivider(),
                  SingleMovieScreenSubtitle(
                    text: movie.genres
                        ?.map((genre) => genre["name"])
                        .join(", "),
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8,
              children: [
                Text(
                  (movie.ratingVoteAverage ?? 0).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                RatingStars(
                  value: movie.ratingVoteAverage ?? 0,
                  onChanged: (value) {},
                ),
              ],
            ),
            ExpandableText(
              text: movie.overview,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(125),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
