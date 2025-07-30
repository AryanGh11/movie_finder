import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/index.dart';

class SingleCastScreenAppBar extends StatelessWidget {
  final Cast cast;
  final LocalUserProvider localUser;

  const SingleCastScreenAppBar({
    super.key,
    required this.cast,
    required this.localUser,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: (MediaQuery.of(context).size.width * 4) / 3,
      pinned: true,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: CustomCachedImage(
          imageUrl: cast.profilePath ?? '',
          fit: BoxFit.cover,
          borderRadius: BorderRadius.zero,
        ),
      ),
      actions: [
        // IconButton(
        //   onPressed: () => localUser.toggleFavorite(cast),
        //   icon: localUser.isFavorite(cast.id)
        //       ? Icon(Icons.favorite)
        //       : Icon(Icons.favorite_outline),
        // ),
        // IconButton(
        //   onPressed: () => localUser.toggleWatchLater(cast),
        //   icon: localUser.isInWatchLater(cast.id)
        //       ? Icon(Icons.bookmark)
        //       : Icon(Icons.bookmark_outline),
        // ),
        IMDB(imdbId: cast.imdbId, type: IMDBType.cast),
      ],
      actionsPadding: EdgeInsets.only(right: 12),
    );
  }
}
