abstract class SingleMovieEvent {}

class FetchMovie extends SingleMovieEvent {
  final int id;
  FetchMovie(this.id);
}
