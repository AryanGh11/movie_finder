import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PopupItems { openMovieInGoogle, openMovieInTelegramBot }

class MovieCardsWithMenuWrapper extends StatelessWidget {
  final Widget child;
  final Movie movie;

  const MovieCardsWithMenuWrapper({
    super.key,
    required this.child,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> openMenu(LongPressStartDetails details) async {
      final selected = await showMenu<PopupItems>(
        context: context,
        position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy,
        ),
        items: [
          PopupMenuItem(
            value: PopupItems.openMovieInGoogle,
            child: Row(
              spacing: 10,
              children: [
                Icon(FontAwesomeIcons.google, size: 16),
                Text("Search in Google"),
              ],
            ),
          ),
          PopupMenuItem(
            value: PopupItems.openMovieInTelegramBot,
            child: Row(
              spacing: 10,
              children: [
                Icon(FontAwesomeIcons.telegram, size: 16),
                Text("Search in Telegram Bot"),
              ],
            ),
          ),
        ],
      );

      if (selected == PopupItems.openMovieInGoogle) {
        movie.openInGoogle(GoogleLangs.persian);
      } else if (selected == PopupItems.openMovieInTelegramBot) {
        movie.openInTelegramBot();
      }
    }

    return Material(
      child: GestureDetector(onLongPressStart: openMenu, child: child),
    );
  }
}
