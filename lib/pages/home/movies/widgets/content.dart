import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/pages/home/movies/widgets/index.dart';

class MoviePageContent extends StatelessWidget {
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;
  final TextEditingController searchController;
  final List<Movie> searchedMovies;

  const MoviePageContent({
    super.key,
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
    required this.searchController,
    required this.searchedMovies,
  });

  @override
  Widget build(BuildContext context) {
    // Display nothing if there are no data to show.
    if (popularMovies.isEmpty &&
        nowPlayingMovies.isEmpty &&
        topRatedMovies.isEmpty &&
        upcomingMovies.isEmpty &&
        searchedMovies.isEmpty) {
      return SizedBox.shrink();
    }

    return searchController.text.isNotEmpty
        ? VerticalCardsList(movies: searchedMovies)
        : ListView(
            padding: const EdgeInsets.only(bottom: 120),
            children: [
              MoviePageCarousel(items: upcomingMovies),
              const SizedBox(height: 20),
              MoviePageHorizontalScrollableBox(
                title: "Popular",
                items: popularMovies,
                itemBuilder: (movie) => VerticalMovieCard(movie: movie),
                itemWidthRatio: 0.45,
              ),
              const SizedBox(height: 20),
              MoviePageHorizontalScrollableBox(
                title: "Now Playing",
                items: nowPlayingMovies,
                itemBuilder: (movie) => HorizontalMovieCard(movie: movie),
              ),
              const SizedBox(height: 20),
              MoviePageVerticalScrollableBox(
                title: "Top Rated",
                items: topRatedMovies,
                itemBuilder: (movie) => OverviewMovieCard(movie: movie),
              ),
              const SizedBox(height: 20),
              MoviePageHorizontalScrollableBox(
                title: "Upcoming",
                items: upcomingMovies,
                itemBuilder: (movie) => HorizontalMovieCard(movie: movie),
              ),
            ],
          );
  }
}
