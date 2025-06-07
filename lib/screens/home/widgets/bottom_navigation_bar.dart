import 'package:flutter/material.dart';

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
                items: const [
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.favorite),
                    icon: Icon(Icons.favorite_outline),
                    label: "Favorites",
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.bookmark),
                    icon: Icon(Icons.bookmark_outline),
                    label: "Bookmark",
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.person),
                    icon: Icon(Icons.person_outline),
                    label: "Profile",
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
