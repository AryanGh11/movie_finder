import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_finder/pages/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/providers/index.dart';

class HomeScreenBody extends StatelessWidget {
  final User user;
  final void Function(User user) onUserUpdated;
  final PageController pageController;
  final void Function(int index) onPageChanged;
  final bool isSearchTextFieldVisible;

  const HomeScreenBody({
    super.key,
    required this.user,
    required this.onUserUpdated,
    required this.pageController,
    required this.onPageChanged,
    required this.isSearchTextFieldVisible,
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
            key: ValueKey("movies_page"),
            child: BlocProvider(
              create: (_) => HomeScreenMoviesBloc()..add(FetchMovies()),
              child: MoviePage(
                isSearchTextFieldVisible: isSearchTextFieldVisible,
              ),
            ),
          ),
          // KeyedSubtree(key: ValueKey("favorites_page"), child: FavoritesPage()),
          KeyedSubtree(
            key: ValueKey("cast_page"),
            child: BlocProvider(
              create: (_) => HomeScreenCastBloc()..add(FetchCast()),
              child: CastPage(
                isSearchTextFieldVisible: isSearchTextFieldVisible,
              ),
            ),
          ),
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
