import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/local_user.dart';
import 'package:movie_finder/pages/home/widgets/index.dart';

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
    return HomePagePadding(
      child: CustomScrollView(
        slivers: [
          const SliverPadding(padding: EdgeInsets.symmetric(horizontal: 20)),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return VerticalMovieCard(movie: _favoriteMovies[index]);
            }, childCount: _favoriteMovies.length),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
            ),
          ),
        ],
      ),
    );
  }
}
