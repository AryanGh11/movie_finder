abstract class HomeScreenMoviesEvent {}

class FetchMovies extends HomeScreenMoviesEvent {}

class SearchMovies extends HomeScreenMoviesEvent {
  final String query;
  SearchMovies(this.query);
}
