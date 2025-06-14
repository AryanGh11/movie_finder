import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/widgets/cards/movie_cards_with_menu_wrapper.dart';

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

    return MovieCardsWithMenuWrapper(
      movie: widget.movie,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.pushNamed(
            context,
            singleMovieRoute,
            arguments: widget.movie.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                        imageUrl: widget.movie.posterPath,
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
                          onPressed: () =>
                              localUser.toggleFavorite(widget.movie),
                          icon: Icon(
                            localUser.isFavorite(widget.movie.id)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              localUser.toggleWatchLater(widget.movie),
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
              const SizedBox(height: 8),
              Text(
                widget.movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(widget.movie.voteAverage?.toString() ?? '-'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
