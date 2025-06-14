import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/screens/home/enums.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreenProfilePopupMenu extends StatelessWidget {
  final User user;

  const HomeScreenProfilePopupMenu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final localUser = Provider.of<LocalUserProvider>(context);

    return PopupMenuButton<ProfileMenuAction>(
      borderRadius: BorderRadius.circular(99999),
      position: PopupMenuPosition.under,
      child: user.photoURL != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(99999),
              child: Image.network(
                user.photoURL!,
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            )
          : Icon(FontAwesomeIcons.solidCircleUser),
      onSelected: (value) async {
        switch (value) {
          case ProfileMenuAction.logout:
            localUser.logout(context);
        }
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem<ProfileMenuAction>(
            height: 10,
            value: ProfileMenuAction.logout,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(backgroundColor: Colors.red),
            child: Row(
              spacing: 8,
              children: [Icon(Icons.logout), Text("Log out")],
            ),
          ),
        ];
      },
    );
  }
}
