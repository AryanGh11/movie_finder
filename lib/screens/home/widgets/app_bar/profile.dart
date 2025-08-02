import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreenAppBarProfile extends StatelessWidget {
  final User user;

  const HomeScreenAppBarProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Row(
        spacing: 10,
        children: [
          user.photoURL != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(99999),
                  child: Image.network(
                    user.photoURL!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(FontAwesomeIcons.solidCircleUser),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                '${AppLocalizations.of(context)!.hi}, ${user.displayName ?? 'User'}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                AppLocalizations.of(context)!.watchAMovie,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.75),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
