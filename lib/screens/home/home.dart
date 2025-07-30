import 'package:flutter/material.dart';
import 'package:movie_finder/screens/index.dart';
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
  int _currentIndex = 0;
  bool _isSearchTextFieldVisible = false;

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
    final bool canSearchButtonVisibile = _pageController.hasClients
        ? (_pageController.page?.round() == 0 ||
              _pageController.page?.round() == 1)
        : (_currentIndex == 0 || _currentIndex == 1);

    if (_user != null) {
      return Scaffold(
        appBar: HomeScreenAppBar(
          user: _user!,
          isSearchTextFieldVisible: _isSearchTextFieldVisible,
          canSearchButtonVisibile: canSearchButtonVisibile,
          toggleSearchTextFieldVisible: () => setState(() {
            _isSearchTextFieldVisible = !_isSearchTextFieldVisible;
          }),
        ),
        drawer: HomeScreenDrawer(
          user: _user!,
          onNavigationTap: _onNavigationTap,
        ),
        body: Column(
          children: [
            Expanded(
              child: HomeScreenBody(
                user: _user!,
                onUserUpdated: _onUserUpdated,
                pageController: _pageController,
                onPageChanged: _onPageChanged,
                isSearchTextFieldVisible: _isSearchTextFieldVisible,
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
