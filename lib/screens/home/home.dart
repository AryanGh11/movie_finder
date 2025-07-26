import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/screens/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/screens/home/widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user = FirebaseAuth.instance.currentUser;
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  Timer? _debounce;
  String? prevQuery;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _pageController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged() {
    final HomeBloc homeBloc = context.read<HomeBloc>();

    if (_debounce != null) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();

      if (query.isNotEmpty) {
        if (prevQuery != query) {
          homeBloc.add(SearchMovies(query));
          setState(() {
            prevQuery = query;
          });
        }
      } else {
        // Only go back to FetchMovies if the bloc is currently in a searched state
        final state = homeBloc.state;
        if (state is HomeSearchResult || state is HomeLoading) {
          context.read<HomeBloc>().add(FetchMovies());
        }
      }
    });
  }

  void _onNavigationTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onUserUpdated(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isHomePage = _pageController.hasClients
        ? _pageController.page?.round() == 0
        : _currentIndex == 0;

    if (_user != null) {
      return Scaffold(
        appBar: HomeScreenAppBar(user: _user!),
        drawer: HomeScreenDrawer(
          user: _user!,
          onNavigationTap: _onNavigationTap,
        ),
        body: Column(
          spacing: isHomePage ? 20 : 0,
          children: [
            isHomePage
                ? GlobalPadding(
                    child: CustomTextField(
                      controller: _searchController,
                      hintText: "Search for movies ...",
                    ),
                  )
                : SizedBox(),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  // Provide empty or real lists depending on state
                  final searchedMovies = state is HomeSearchResult
                      ? state.results
                      : <Movie>[];
                  final popular = state is HomeLoaded
                      ? state.popular
                      : <Movie>[];
                  final nowPlaying = state is HomeLoaded
                      ? state.nowPlaying
                      : <Movie>[];
                  final topRated = state is HomeLoaded
                      ? state.topRated
                      : <Movie>[];
                  final upcoming = state is HomeLoaded
                      ? state.upcoming
                      : <Movie>[];

                  if (state is HomeError) {
                    return Center(child: Text(state.message));
                  }

                  return HomeScreenBody(
                    user: _user!,
                    onUserUpdated: _onUserUpdated,
                    pageController: _pageController,
                    onPageChanged: _onPageChanged,
                    searchController: _searchController,
                    popularMovies: popular,
                    nowPlayingMovies: nowPlaying,
                    topRatedMovies: topRated,
                    upcomingMovies: upcoming,
                    searchedMovies: searchedMovies,
                  );
                },
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: HomeScreenBottomNavigationBar(
          currentIndex: _currentIndex,
          onNavigationTap: _onNavigationTap,
        ),
      );
    } else {
      return const IntroScreen();
    }
  }
}
