abstract class CastEvent {}

class FetchCast extends CastEvent {
  final int id;
  FetchCast(this.id);
}
