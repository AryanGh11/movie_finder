import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/services/index.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class LocalUserProvider extends ChangeNotifier {
  final Box<LocalUser> _localUserBox = Hive.box<LocalUser>('localUserBox');

  LocalUser get _localUser => _localUserBox.get('user')!;

  List<Movie> get favorites => _localUser.favorites;
  List<Movie> get watchLater => _localUser.watchLater;
  String get appLang => _localUser.appLang;

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie.id)) {
      _localUser.favorites.removeWhere((m) => m.id == movie.id);
    } else {
      _localUser.favorites.add(movie);
    }
    _localUser.save();
    notifyListeners();
  }

  void toggleWatchLater(Movie movie) {
    if (isInWatchLater(movie.id)) {
      _localUser.watchLater.removeWhere((m) => m.id == movie.id);
    } else {
      _localUser.watchLater.add(movie);
    }
    _localUser.save();
    notifyListeners();
  }

  void toggleLang(BuildContext context) {
    _localUser.appLang = _localUser.appLang == "en" ? "fa" : "en";
    _localUser.save();
    notifyListeners();
    Phoenix.rebirth(context);
  }

  Future<void> logout(BuildContext context) async {
    await AuthService.signOut();
    Navigator.of(
      // ignore: use_build_context_synchronously
      context,
    ).pushNamedAndRemoveUntil(introRoute, (route) => false);
  }

  bool isFavorite(int movieId) {
    return _localUser.favorites.any((m) => m.id == movieId);
  }

  bool isInWatchLater(int movieId) {
    return _localUser.watchLater.any((m) => m.id == movieId);
  }
}
