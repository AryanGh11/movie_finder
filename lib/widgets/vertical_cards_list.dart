import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';

class VerticalCardsList extends StatelessWidget {
  final List<Movie> movies;

  const VerticalCardsList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = 20.0;
    final spacing = 0.0;
    final totalHorizontalSpacing = (horizontalPadding * 2) + spacing;

    // Calculate width of each card (2 columns)
    final itemWidth = (screenWidth - totalHorizontalSpacing) / 2;

    // Define a fixed or responsive height (based on image or design)
    final itemHeight = itemWidth * 1.65;
    final aspectRatio = itemWidth / itemHeight;

    return movies.isNotEmpty
        ? CustomScrollView(
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return VerticalMovieCard(movie: movies[index]);
                }, childCount: movies.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: aspectRatio,
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
            ],
          )
        : Center(child: Text(AppLocalizations.of(context)!.dataNotFound));
  }
}
