import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';

class HomeScreenBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onNavigationTap;

  const HomeScreenBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavigationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Theme.of(context).colorScheme.secondary,
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                onTap: onNavigationTap,
                elevation: 0,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Colors.grey[500],
                selectedFontSize: 12,
                unselectedFontSize: 12,
                items: [
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.movie),
                    icon: Icon(Icons.movie_outlined),
                    label: AppLocalizations.of(context)!.movies,
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.theater_comedy),
                    icon: Icon(Icons.theater_comedy_outlined),
                    label: AppLocalizations.of(context)!.cast,
                  ),
                  // BottomNavigationBarItem(
                  //   activeIcon: Icon(Icons.favorite),
                  //   icon: Icon(Icons.favorite_outline),
                  //   label: "Favorites",
                  // ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.bookmark),
                    icon: Icon(Icons.bookmark_outline),
                    label: AppLocalizations.of(context)!.bookmark,
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.person),
                    icon: Icon(Icons.person_outline),
                    label: AppLocalizations.of(context)!.profile,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
