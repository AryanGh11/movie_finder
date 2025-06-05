import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/screens/home/widgets/index.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;

  const HomeScreenAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: EdgeInsets.only(right: 20),
      title: AppTitleIcon(onTap: () => Scaffold.of(context).openDrawer()),
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [HomeScreenProfilePopupMenu(user: user)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
