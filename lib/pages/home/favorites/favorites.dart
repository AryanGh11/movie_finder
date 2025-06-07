import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/index.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Movie> _favoriteMovies = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getFavoriteMovies();
  }

  void _getFavoriteMovies() {
    setState(() {
      _favoriteMovies = Provider.of<LocalUserProvider>(context).favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VerticalCardsList(movies: _favoriteMovies);
  }
}
