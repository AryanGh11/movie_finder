import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/pages/home/home/widgets/index.dart';

class HomePage extends StatefulWidget {
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;
  final TextEditingController searchController;
  final List<Movie> searchedMovies;

  const HomePage({
    super.key,
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
    required this.searchController,
    required this.searchedMovies,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: widget.searchController,
          hintText: "Search for movies ...",
        ),
        const SizedBox(height: 20),
        Expanded(
          child: HomePageContent(
            popularMovies: widget.popularMovies,
            nowPlayingMovies: widget.nowPlayingMovies,
            topRatedMovies: widget.topRatedMovies,
            upcomingMovies: widget.upcomingMovies,
            searchController: widget.searchController,
            searchedMovies: widget.searchedMovies,
          ),
        ),
      ],
    );
  }
}
