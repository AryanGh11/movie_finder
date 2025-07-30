import 'package:movie_finder/models/index.dart';

abstract class HomeScreenMoviesState {}

class HomeScreenMoviesInitial extends HomeScreenMoviesState {}

class HomeScreenMoviesLoading extends HomeScreenMoviesState {}

class HomeScreenMoviesLoaded extends HomeScreenMoviesState {
  final List<Movie> popular;
  final List<Movie> nowPlaying;
  final List<Movie> topRated;
  final List<Movie> upcoming;

  HomeScreenMoviesLoaded({
    required this.popular,
    required this.nowPlaying,
    required this.topRated,
    required this.upcoming,
  });
}

class HomeScreenMoviesSearchResult extends HomeScreenMoviesState {
  final List<Movie> results;

  HomeScreenMoviesSearchResult(this.results);
}

class HomeScreenMoviesError extends HomeScreenMoviesState {
  final String message;
  HomeScreenMoviesError(this.message);
}
