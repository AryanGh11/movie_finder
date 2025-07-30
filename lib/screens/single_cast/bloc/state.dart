import 'package:movie_finder/models/index.dart';

abstract class CastState {}

class CastInitial extends CastState {}

class CastLoading extends CastState {}

class CastLoaded extends CastState {
  final Cast? cast;

  CastLoaded({required this.cast});
}

class CastError extends CastState {
  final String message;
  CastError(this.message);
}
