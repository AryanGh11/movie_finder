import 'state.dart';
import 'event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/services/index.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<SearchMovies>(_onSearchMovies);
  }

  Future<void> _onFetchMovies(
    FetchMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final popular = await TMDBService.getPopularMovies();
      final nowPlaying = await TMDBService.getNowPlayingMovies();
      final topRated = await TMDBService.getTopRatedMovies();
      final upcoming = await TMDBService.getUpcomingMovies();

      emit(
        HomeLoaded(
          popular: popular,
          nowPlaying: nowPlaying,
          topRated: topRated,
          upcoming: upcoming,
        ),
      );
    } catch (e) {
      emit(HomeError('Failed to fetch movies.'));
    }
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final results = await TMDBService.searchMovies(event.query);
      emit(HomeSearchResult(results));
    } catch (e) {
      emit(HomeError('Search failed.'));
    }
  }
}
