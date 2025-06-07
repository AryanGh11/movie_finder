import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/screens/single_movie/bloc/index.dart';
import 'package:movie_finder/screens/single_movie/widgets/index.dart';

class SingleMovieScreen extends StatefulWidget {
  const SingleMovieScreen({super.key});

  @override
  State<SingleMovieScreen> createState() => _SingleMovieScreenState();
}

class _SingleMovieScreenState extends State<SingleMovieScreen> {
  @override
  Widget build(BuildContext context) {
    final localUser = Provider.of<LocalUserProvider>(context);
    final movieId = ModalRoute.of(context)?.settings.arguments as int?;

    return BlocProvider(
      create: (_) => SingleMovieBloc()..add(FetchMovie(movieId ?? -1)),
      child: BlocBuilder<SingleMovieBloc, SingleMovieState>(
        builder: (context, state) {
          if (state is SingleMovieLoading) {
            return Scaffold(
              body: Center(child: CustomCircularProgressIndicator()),
            );
          }

          if (state is SingleMovieLoaded) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SingleMovieScreenAppBar(
                    movie: state.movie!,
                    localUser: localUser,
                  ),
                  SingleMovieScreenContent(movie: state.movie!),
                ],
              ),
              bottomNavigationBar: state.movie != null
                  ? SingleMovieScreenBottomNavigationBar(movie: state.movie!)
                  : null,
            );
          }

          return Scaffold(body: ErrorView());
        },
      ),
    );
  }
}
