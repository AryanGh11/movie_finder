import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/screens/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/screens/home/bloc/index.dart';
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
    final query = _searchController.text.trim();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        context.read<HomeBloc>().add(SearchMovies(query));
      } else {
        context.read<HomeBloc>().add(FetchMovies());
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
    return BlocProvider(
      create: (_) => HomeBloc()..add(FetchMovies()),
      child: _user != null
          ? Scaffold(
              appBar: HomeScreenAppBar(user: _user!),
              drawer: HomeScreenDrawer(
                user: _user!,
                onNavigationTap: _onNavigationTap,
              ),
              body: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoaded) {
                    return HomeScreenBody(
                      user: _user!,
                      onUserUpdated: _onUserUpdated,
                      pageController: _pageController,
                      onPageChanged: _onPageChanged,
                      searchController: _searchController,
                      popularMovies: state.popular,
                      nowPlayingMovies: state.nowPlaying,
                      topRatedMovies: state.topRated,
                      upcomingMovies: state.upcoming,
                      searchedMovies: [],
                    );
                  } else if (state is HomeSearchResult) {
                    return HomeScreenBody(
                      user: _user!,
                      onUserUpdated: _onUserUpdated,
                      pageController: _pageController,
                      onPageChanged: _onPageChanged,
                      searchController: _searchController,
                      popularMovies: [],
                      nowPlayingMovies: [],
                      topRatedMovies: [],
                      upcomingMovies: [],
                      searchedMovies: state.results,
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
              extendBody: true,
              bottomNavigationBar: HomeScreenBottomNavigationBar(
                currentIndex: _currentIndex,
                onNavigationTap: _onNavigationTap,
              ),
            )
          : const IntroScreen(),
    );
  }
}
