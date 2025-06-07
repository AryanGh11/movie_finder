import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/services/tmdb_service.dart';
import 'package:movie_finder/screens/single_movie/bloc/index.dart';

class SingleMovieBloc extends Bloc<SingleMovieEvent, SingleMovieState> {
  SingleMovieBloc() : super(SingleMovieInitial()) {
    on<FetchMovie>(_onFetchMovie);
  }

  Future<void> _onFetchMovie(
    FetchMovie event,
    Emitter<SingleMovieState> emit,
  ) async {
    emit(SingleMovieLoading());
    try {
      final movie = await TMDBService.getDetailedMovie(event.id);
      emit(SingleMovieLoaded(movie: movie));
    } catch (e) {
      emit(SingleMovieError('Failed to fetch movie'));
    }
  }
}
