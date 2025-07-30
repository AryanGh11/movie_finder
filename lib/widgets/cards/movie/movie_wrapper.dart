import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';

enum PopupItems { openMovieInGoogle, openMovieInTelegramBot }

class MovieCardWrapper extends StatelessWidget {
  final Widget child;
  final Movie movie;

  const MovieCardWrapper({super.key, required this.child, required this.movie});

  @override
  Widget build(BuildContext context) {
    Future<void> openMenu(LongPressStartDetails details) async {
      final selected = await showMenu<DownloadOptionsPopupValues>(
        context: context,
        position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy,
        ),
        items: downloadOptions
            .map(
              (option) => PopupMenuItem(
                value:
                    option[DownloadOptionsKeys.value]
                        as DownloadOptionsPopupValues,
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(option[DownloadOptionsKeys.icon], size: 16),
                    Text(option[DownloadOptionsKeys.title]),
                  ],
                ),
              ),
            )
            .toList(),
      );

      if (selected == DownloadOptionsPopupValues.neterplay) {
        movie.openInNeterplay();
      } else if (selected == DownloadOptionsPopupValues.telegramBot) {
        movie.openInTelegramBot();
      }
    }

    return Material(
      child: GestureDetector(
        onLongPressStart: openMenu,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(context, singleMovieRoute, arguments: movie.id);
          },
          child: Padding(padding: const EdgeInsets.all(5), child: child),
        ),
      ),
    );
  }
}
