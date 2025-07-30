import 'state.dart';
import 'event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/services/index.dart';

class HomeScreenCastBloc
    extends Bloc<HomeScreenCastEvent, HomeScreenCastState> {
  HomeScreenCastBloc() : super(HomeScreenCastInitial()) {
    on<FetchCast>(_onFetchCast);
    on<SearchCast>(_onSearchCast);
  }

  Future<void> _onFetchCast(
    FetchCast event,
    Emitter<HomeScreenCastState> emit,
  ) async {
    emit(HomeScreenCastLoading());
    try {
      final popular = await TMDBService.getPopularCast();

      emit(HomeScreenCastLoaded(popular: popular));
    } catch (e) {
      emit(HomeScreenCastError('Failed to fetch cast.'));
    }
  }

  Future<void> _onSearchCast(
    SearchCast event,
    Emitter<HomeScreenCastState> emit,
  ) async {
    emit(HomeScreenCastLoading());
    try {
      final results = await TMDBService.searchCast(event.query);
      emit(HomeScreenCastSearchResult(results));
    } catch (e) {
      emit(HomeScreenCastError('Search failed.'));
    }
  }
}
