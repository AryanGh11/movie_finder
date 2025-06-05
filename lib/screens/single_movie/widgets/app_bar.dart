import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/local_user.dart';

class SingleMovieScreenAppBar extends StatelessWidget {
  final Movie movie;
  final LocalUserProvider localUser;

  const SingleMovieScreenAppBar({
    super.key,
    required this.movie,
    required this.localUser,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 2,
      pinned: true,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: CustomCachedImage(
          imageUrl: movie.posterPath,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.zero,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => localUser.toggleFavorite(movie),
          icon: localUser.isFavorite(movie.id)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_outline),
        ),
        IconButton(
          onPressed: () => localUser.toggleWatchLater(movie),
          icon: localUser.isInWatchLater(movie.id)
              ? Icon(Icons.bookmark)
              : Icon(Icons.bookmark_outline),
        ),
        IMDB(imdbId: movie.imdbId),
      ],
      actionsPadding: EdgeInsets.only(right: 12),
    );
  }
}
