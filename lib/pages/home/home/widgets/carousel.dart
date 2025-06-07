import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/models/hive/index.dart';
import 'package:movie_finder/services/tmdb_service.dart';

class HomePageCarousel extends StatefulWidget {
  final List<Movie> items;

  const HomePageCarousel({super.key, required this.items});

  @override
  State<HomePageCarousel> createState() => _HomePageCarouselState();
}

class _HomePageCarouselState extends State<HomePageCarousel> {
  Future<String?> _getBackdropPath(int movieId) async {
    try {
      final res = await TMDBService.getMovieImages(movieId);
      if (!mounted) return null;
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
                    child: CustomCachedImage(
                      imageUrl: backdropPath,
                      fit: BoxFit.cover,
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
