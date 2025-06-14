import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/services/index.dart';

class LocalUserProvider extends ChangeNotifier {
  final Box<LocalUser> _localUserBox = Hive.box<LocalUser>('localUserBox');

  LocalUser get _localUser => _localUserBox.get('user')!;

  List<Movie> get favorites => _localUser.favorites;
  List<Movie> get watchLater => _localUser.watchLater;

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
