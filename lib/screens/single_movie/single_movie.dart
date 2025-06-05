import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/utils/error_handler.dart';
import 'package:movie_finder/providers/local_user.dart';
import 'package:movie_finder/services/tmdb_service.dart';
import 'package:movie_finder/screens/single_movie/widgets/index.dart';

class SingleMovieScreen extends StatefulWidget {
  const SingleMovieScreen({super.key});

  @override
  State<SingleMovieScreen> createState() => _SingleMovieScreenState();
}

class _SingleMovieScreenState extends State<SingleMovieScreen> {
  bool isLoading = false;
  Movie? movie;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movieId = ModalRoute.of(context)?.settings.arguments as int?;

      if (movieId != null) {
        _getDetailedMovie(movieId);
      } else {
        ErrorHandler.handle("Movie ID not provided");
      }
    });
  }

  Future<void> _getDetailedMovie(int id) async {
    setState(() {
      isLoading = true;
    });

    try {
      final res = await TMDBService.getDetailedMovie(id);
      setState(() {
        movie = res;
      });
    } catch (e) {
      setState(() {
        movie = null;
      });
      ErrorHandler.handle(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localUser = Provider.of<LocalUserProvider>(context);

    return Scaffold(
      body: isLoading
          ? Center(child: CustomCircularProgressIndicator())
          : movie != null
          ? CustomScrollView(
              slivers: [
                SingleMovieScreenAppBar(movie: movie!, localUser: localUser),
                SingleMovieScreenContent(movie: movie!),
              ],
            )
          : ErrorView(),
      bottomNavigationBar: movie != null
          ? SingleMovieScreenBottomNavigationBar(movie: movie!)
          : null,
    );
  }
}
