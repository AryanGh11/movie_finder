import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/services/index.dart';
import 'package:movie_finder/screens/single_cast/bloc/index.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  CastBloc() : super(CastInitial()) {
    on<FetchCast>(_onFetchCast);
  }

  Future<void> _onFetchCast(
    FetchCast event,
    Emitter<CastState> emit,
  ) async {
    emit(CastLoading());
    try {
      final cast = await TMDBService.getDetailedCast(event.id);
      emit(CastLoaded(cast: cast));
    } catch (e) {
      emit(CastError('Failed to fetch cast'));
    }
  }
}
