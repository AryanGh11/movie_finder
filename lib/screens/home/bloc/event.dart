abstract class HomeEvent {}

class FetchMovies extends HomeEvent {}

class SearchMovies extends HomeEvent {
  final String query;
  SearchMovies(this.query);
}
