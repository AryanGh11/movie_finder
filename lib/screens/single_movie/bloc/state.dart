import 'package:movie_finder/models/index.dart';

abstract class SingleMovieState {}

class SingleMovieInitial extends SingleMovieState {}

class SingleMovieLoading extends SingleMovieState {}

class SingleMovieLoaded extends SingleMovieState {
  final Movie? movie;

  SingleMovieLoaded({required this.movie});
}

class SingleMovieError extends SingleMovieState {
  final String message;
  SingleMovieError(this.message);
}
