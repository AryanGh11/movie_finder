import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/index.dart';

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
    return VerticalCardsList(movies: _watchLaterMovies);
  }
}
