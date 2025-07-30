abstract class HomeScreenCastEvent {}

class FetchCast extends HomeScreenCastEvent {}

class SearchCast extends HomeScreenCastEvent {
  final String query;
  SearchCast(this.query);
}
