import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/services/index.dart';

class CastPageContent extends StatelessWidget {
  final List<Cast> popularCast;
  final List<Cast> searchedCast;
  final TextEditingController searchController;

  const CastPageContent({
    super.key,
    required this.popularCast,
    required this.searchedCast,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    // Display nothing if there are no data to show.
    if (popularCast.isEmpty && searchedCast.isEmpty) {
      return SizedBox.shrink();
    }

    return searchController.text.isNotEmpty
        ? InfiniteScrollableList<Cast>(
            items: searchedCast,
            itemBuilder: (dynamic item) => OverviewCastCard(cast: item as Cast),
            onLoadMore: (_) => null,
            itemHeightRatio: 1.3,
          )
        : InfiniteScrollableList<Cast>(
            items: popularCast,
            itemBuilder: (dynamic item) => OverviewCastCard(cast: item as Cast),
            onLoadMore: (page) async =>
                await TMDBService.getPopularCast(page: page),
            itemHeightRatio: 1.3,
          );
  }
}
