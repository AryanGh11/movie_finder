import 'state.dart';
import 'event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/services/index.dart';

class HomeScreenMoviesBloc
    extends Bloc<HomeScreenMoviesEvent, HomeScreenMoviesState> {
  HomeScreenMoviesBloc() : super(HomeScreenMoviesInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<SearchMovies>(_onSearchMovies);
  }

  Future<void> _onFetchMovies(
    FetchMovies event,
    Emitter<HomeScreenMoviesState> emit,
  ) async {
    emit(HomeScreenMoviesLoading());
    try {
      final popular = await TMDBService.getPopularMovies();
      final nowPlaying = await TMDBService.getNowPlayingMovies();
      final topRated = await TMDBService.getTopRatedMovies();
      final upcoming = await TMDBService.getUpcomingMovies();

      emit(
        HomeScreenMoviesLoaded(
          popular: popular,
          nowPlaying: nowPlaying,
          topRated: topRated,
          upcoming: upcoming,
        ),
      );
    } catch (e) {
      emit(HomeScreenMoviesError('Failed to fetch movies.'));
    }
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<HomeScreenMoviesState> emit,
  ) async {
    emit(HomeScreenMoviesLoading());
    try {
      final results = await TMDBService.searchMovies(event.query);
      emit(HomeScreenMoviesSearchResult(results));
    } catch (e) {
      emit(HomeScreenMoviesError('Search failed.'));
    }
  }
}
