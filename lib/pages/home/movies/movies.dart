import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';
import 'package:movie_finder/pages/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/constants/index.dart';
import 'package:movie_finder/pages/home/movies/widgets/index.dart';

class MoviePage extends StatefulWidget {
  final bool isSearchTextFieldVisible;

  const MoviePage({super.key, required this.isSearchTextFieldVisible});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String? _prevQuery;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged() {
    final HomeScreenMoviesBloc homeBloc = context.read<HomeScreenMoviesBloc>();

    if (_debounce != null) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();

      if (query.isNotEmpty) {
        if (_prevQuery != query) {
          homeBloc.add(SearchMovies(query));
          setState(() {
            _prevQuery = query;
          });
        }
      } else {
        // Only go back to FetchMovie if the bloc is currently in a searched state
        final state = homeBloc.state;
        if (state is HomeScreenMoviesSearchResult ||
            state is HomeScreenMoviesLoading) {
          context.read<HomeScreenMoviesBloc>().add(FetchMovies());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: widget.isSearchTextFieldVisible
              ? CustomTextField(
                  controller: _searchController,
                  hintText: AppLocalizations.of(context)!.searchForMovies,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomIcon(
                      path: IconsPaths.search,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          child: BlocBuilder<HomeScreenMoviesBloc, HomeScreenMoviesState>(
            builder: (context, state) {
              // Provide empty or real lists depending on state
              final searchedMovies = state is HomeScreenMoviesSearchResult
                  ? state.results
                  : <Movie>[];
              final popularMovies = state is HomeScreenMoviesLoaded
                  ? state.popular
                  : <Movie>[];
              final nowPlayingMovies = state is HomeScreenMoviesLoaded
                  ? state.popular
                  : <Movie>[];
              final topRatedMovies = state is HomeScreenMoviesLoaded
                  ? state.topRated
                  : <Movie>[];
              final upcomingMovies = state is HomeScreenMoviesLoaded
                  ? state.upcoming
                  : <Movie>[];

              if (state is HomeScreenMoviesLoading) {
                return Center(child: CustomCircularProgressIndicator());
              }

              return MoviePageContent(
                popularMovies: popularMovies,
                nowPlayingMovies: nowPlayingMovies,
                topRatedMovies: topRatedMovies,
                upcomingMovies: upcomingMovies,
                searchedMovies: searchedMovies,
                searchController: _searchController,
              );
            },
          ),
        ),
      ],
    );
  }
}
