import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';

class GenericMoviesListScreen extends StatefulWidget {
  const GenericMoviesListScreen({super.key});

  @override
  State<GenericMoviesListScreen> createState() =>
      _GenericMoviesListScreenState();
}

class _GenericMoviesListScreenState extends State<GenericMoviesListScreen> {
  List<Movie> _movies = [];
  String _appBarTitle = "Movies";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      final argMovies = arguments?["movies"] as List<Movie>?;
      final argAppBarTitle = arguments?["title"] as String?;

      if (argMovies != null) {
        setState(() {
          _movies = argMovies;
          _appBarTitle = argAppBarTitle ?? "Movies";
        });
      } else {
        ErrorHandler.handle("Movie list not provided");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _movies.isNotEmpty
          ? VerticalCardsList(movies: _movies)
          : ErrorView(),
    );
  }
}
