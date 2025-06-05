import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/pages/home/index.dart';
import 'package:movie_finder/providers/local_user.dart';
import 'package:movie_finder/screens/intro/intro.dart';
import 'package:movie_finder/utils/error_handler.dart';
import 'package:movie_finder/services/tmdb_service.dart';
import 'package:movie_finder/screens/home/widgets/index.dart';
import 'package:provider/provider.dart';

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
  List<Movie> _popularMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _upcomingMovies = [];
  List<Movie> _searchedMovies = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
    getMovies();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.removeListener(_onSearchTextChanged);
    _pageController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
  }

  Future<void> getMovies() async {
    try {
      final List<Movie> popularMoviesRes = await TMDBService.getPopularMovies();
      final List<Movie> nowPlayingMoviesRes =
          await TMDBService.getNowPlayingMovies();
      final List<Movie> topRatedMoviesRes =
          await TMDBService.getTopRatedMovies();
      final List<Movie> upcomingMoviesRes =
          await TMDBService.getUpcomingMovies();

      setState(() {
        _popularMovies = popularMoviesRes;
        _nowPlayingMovies = nowPlayingMoviesRes;
        _topRatedMovies = topRatedMoviesRes;
        _upcomingMovies = upcomingMoviesRes;
      });
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<void> searchMovies(String query) async {
    try {
      final List<Movie> res = await TMDBService.searchMovies(query);

      setState(() {
        _searchedMovies = res;
      });
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  void _onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onSearchTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 200), () {
      final query = _searchController.text.trim();

      if (query.isNotEmpty) {
        searchMovies(query);
      } else {
        getMovies();
      }
    });
  }

  void _onUserUpdated(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null) {
      return Scaffold(
        appBar: HomeScreenAppBar(user: _user!),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  _user!.displayName ?? "Unknown user",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  _onNavigationTap(0);
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Search'),
                onTap: () {
                  Navigator.pop(context);
                  _onNavigationTap(1);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            KeyedSubtree(
              key: ValueKey("home_page"),
              child: HomePage(
                popularMovies: _popularMovies,
                nowPlayingMovies: _nowPlayingMovies,
                topRatedMovies: _topRatedMovies,
                upcomingMovies: _upcomingMovies,
                searchController: _searchController,
                searchedMovies: _searchedMovies,
              ),
            ),
            KeyedSubtree(
              key: ValueKey("favorites_page"),
              child: FavoritesPage(),
            ),
            KeyedSubtree(
              key: ValueKey("bookmarks_page"),
              child: BookmarksPage(),
            ),
            KeyedSubtree(
              key: ValueKey("profile_page"),
              child: ProfilePage(
                fUser: _user!,
                onFUserUpdated: _onUserUpdated,
                localUser: Provider.of<LocalUserProvider>(context),
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
      return IntroScreen();
    }
  }
}
