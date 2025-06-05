import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/local_user.dart';
import 'package:movie_finder/pages/home/widgets/index.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List<Movie> _watchLaterMovies = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getFavoriteMovies();
  }

  void _getFavoriteMovies() {
    setState(() {
      _watchLaterMovies = Provider.of<LocalUserProvider>(context).watchLater;
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
              return VerticalMovieCard(movie: _watchLaterMovies[index]);
            }, childCount: _watchLaterMovies.length),
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
