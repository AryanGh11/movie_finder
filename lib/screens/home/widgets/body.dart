import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/pages/home/index.dart';

class HomeScreenBody extends StatelessWidget {
  final User user;
  final void Function(User user) onUserUpdated;
  final PageController pageController;
  final void Function(int index) onPageChanged;
  final TextEditingController searchController;
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> searchedMovies;

  const HomeScreenBody({
    super.key,
    required this.user,
    required this.onUserUpdated,
    required this.pageController,
    required this.onPageChanged,
    required this.searchController,
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
    required this.searchedMovies,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalPadding(
      child: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          KeyedSubtree(
            key: ValueKey("home_page"),
            child: HomePage(
              popularMovies: popularMovies,
              nowPlayingMovies: nowPlayingMovies,
              topRatedMovies: topRatedMovies,
              upcomingMovies: upcomingMovies,
              searchController: searchController,
              searchedMovies: searchedMovies,
            ),
          ),
          KeyedSubtree(key: ValueKey("favorites_page"), child: FavoritesPage()),
          KeyedSubtree(key: ValueKey("bookmarks_page"), child: BookmarksPage()),
          KeyedSubtree(
            key: ValueKey("profile_page"),
            child: ProfilePage(
              fUser: user,
              onFUserUpdated: onUserUpdated,
              localUser: Provider.of<LocalUserProvider>(context),
            ),
          ),
        ],
      ),
    );
  }
}
