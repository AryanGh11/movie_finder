import 'package:movie_finder/models/index.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Movie> popular;
  final List<Movie> nowPlaying;
  final List<Movie> topRated;
  final List<Movie> upcoming;

  HomeLoaded({
    required this.popular,
    required this.nowPlaying,
    required this.topRated,
    required this.upcoming,
  });
}

class HomeSearchResult extends HomeState {
  final List<Movie> results;

  HomeSearchResult(this.results);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
