import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/widgets/cards/movie/movie_wrapper.dart';

class VerticalMovieCard extends StatefulWidget {
  final Movie movie;

  const VerticalMovieCard({super.key, required this.movie});

  @override
  State<VerticalMovieCard> createState() => _VerticalMovieCardState();
}

class _VerticalMovieCardState extends State<VerticalMovieCard> {
  @override
  Widget build(BuildContext context) {
    final localUser = Provider.of<LocalUserProvider>(context);

    return MovieCardWrapper(
      movie: widget.movie,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: CustomCachedImage(
                    key: ValueKey(widget.movie.posterPath),
                    imageUrl: widget.movie.posterPath ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    fullScreenOnTap: false,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => localUser.toggleFavorite(widget.movie),
                      icon: Icon(
                        localUser.isFavorite(widget.movie.id)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () => localUser.toggleWatchLater(widget.movie),
                      icon: Icon(
                        localUser.isInWatchLater(widget.movie.id)
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            spacing: 10,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.movie.voteAverage?.toString() ?? '-',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              DotDivider(),
              Text(
                widget.movie.releaseYear?.toString() ?? "",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
