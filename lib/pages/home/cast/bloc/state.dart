import 'package:movie_finder/models/index.dart';

abstract class HomeScreenCastState {}

class HomeScreenCastInitial extends HomeScreenCastState {}

class HomeScreenCastLoading extends HomeScreenCastState {}

class HomeScreenCastLoaded extends HomeScreenCastState {
  final List<Cast> popular;

  HomeScreenCastLoaded({required this.popular});
}

class HomeScreenCastSearchResult extends HomeScreenCastState {
  final List<Cast> results;

  HomeScreenCastSearchResult(this.results);
}

class HomeScreenCastError extends HomeScreenCastState {
  final String message;
  HomeScreenCastError(this.message);
}
