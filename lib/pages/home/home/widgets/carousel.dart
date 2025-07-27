import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/services/index.dart';

class HomePageCarousel extends StatefulWidget {
  final List<Movie> items;

  const HomePageCarousel({super.key, required this.items});

  @override
  State<HomePageCarousel> createState() => _HomePageCarouselState();
}

class _HomePageCarouselState extends State<HomePageCarousel> {
  final Map<int, String?> _backdropCache = {};

  Future<String?> _getBackdropPath(int movieId) async {
    if (_backdropCache.containsKey(movieId)) {
      return _backdropCache[movieId];
    }

    try {
      final res = await TMDBService.getMovieImages(movieId);
      if (!mounted) return null;
      _backdropCache[movieId] = res.backdropPath;
      return res.backdropPath;
    } catch (e) {
      if (mounted) ErrorHandler.handle(e);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Carousel(
      items: widget.items.isNotEmpty
          ? widget.items.sublist(0, 4).map((movie) {
              return FutureBuilder<String?>(
                future: _getBackdropPath(movie.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final String backdropPath = snapshot.data ?? '';

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        singleMovieRoute,
                        arguments: movie.id,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          CustomCachedImage(
                            imageUrl: backdropPath,
                            fit: BoxFit.cover,
                            fullScreenOnTap: false,
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.black, Colors.transparent],
                                  stops: [0.2, 1],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 12,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${movie.title} ${movie.releaseYear}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      movie.overview,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.75),
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      singleMovieRoute,
                                      arguments: movie.id,
                                    );
                                  },
                                  child: const Text("Watch Now"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList()
          : [],
      height: 200,
    );
  }
}
