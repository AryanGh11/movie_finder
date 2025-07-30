import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/constants/index.dart';
import 'package:movie_finder/screens/home/widgets/app_bar/profile.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final bool isSearchTextFieldVisible;
  final bool canSearchButtonVisibile;
  final void Function() toggleSearchTextFieldVisible;

  const HomeScreenAppBar({
    super.key,
    required this.user,
    required this.isSearchTextFieldVisible,
    required this.canSearchButtonVisibile,
    required this.toggleSearchTextFieldVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: EdgeInsets.only(right: 20),
      title: HomeScreenAppBarProfile(user: user),
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [
        if (canSearchButtonVisibile)
          IconButton(
            icon: CustomIcon(path: IconsPaths.search),
            style: ButtonStyle(
              backgroundColor: isSearchTextFieldVisible
                  ? WidgetStatePropertyAll(Theme.of(context).focusColor)
                  : null,
            ),
            onPressed: () => toggleSearchTextFieldVisible(),
            tooltip: "Search for any movies ...",
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
