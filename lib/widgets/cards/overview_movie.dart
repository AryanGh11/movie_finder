import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/services/index.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/widgets/cards/movie_wrapper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OverviewMovieCard extends StatefulWidget {
  final Movie movie;

  const OverviewMovieCard({super.key, required this.movie});

  @override
  State<OverviewMovieCard> createState() => _OverviewMovieCardState();
}

class _OverviewMovieCardState extends State<OverviewMovieCard> {
  String? _backdropPath;

  @override
  void initState() {
    super.initState();
    _getBackdropPath();
  }

  Future<void> _getBackdropPath() async {
    try {
      final res = await TMDBService.getMovieImages(widget.movie.id);
      if (!mounted) return;
      setState(() {
        _backdropPath = res.backdropPath;
      });
    } catch (e) {
      if (mounted) ErrorHandler.handle(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localUser = Provider.of<LocalUserProvider>(context);

    return MovieCardWrapper(
      movie: widget.movie,
      child: Row(
        spacing: 20,
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CustomCachedImage(
                    key: ValueKey(_backdropPath ?? ""),
                    imageUrl: _backdropPath ?? "",
                    fit: BoxFit.cover,
                    width: 100,
                    fullScreenOnTap: false,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Column(
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
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    Text(
                      widget.movie.releaseYear?.toString() ?? "",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: null,
              icon: Icon(
                FontAwesomeIcons.play,
                size: 12,
                color: Theme.of(context).colorScheme.surface,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
