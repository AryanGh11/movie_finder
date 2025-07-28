import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';

class SingleMovieScreenBottomNavigationBar extends StatelessWidget {
  final Movie movie;

  const SingleMovieScreenBottomNavigationBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final Map<DownloadOptionsKeys, dynamic> neterplayDownloadOption =
        downloadOptions.firstWhere(
          (option) =>
              option[DownloadOptionsKeys.value] ==
              DownloadOptionsPopupValues.neterplay,
        );

    final Map<DownloadOptionsKeys, dynamic> telegramBotDownloadOption =
        downloadOptions.firstWhere(
          (option) =>
              option[DownloadOptionsKeys.value] ==
              DownloadOptionsPopupValues.telegramBot,
        );

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 40, right: 16, left: 16),
      child: Row(
        spacing: 10,
        children: [
          Flexible(
            flex: 5,
            child: CustomElevatedButton(
              prefixIcon: neterplayDownloadOption[DownloadOptionsKeys.icon],
              text: neterplayDownloadOption[DownloadOptionsKeys.title],
              onPressed: () =>
                  neterplayDownloadOption[DownloadOptionsKeys.onSubmit](movie),
              variant:
                  neterplayDownloadOption[DownloadOptionsKeys.buttonVariant],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                telegramBotDownloadOption[DownloadOptionsKeys.icon],
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
              onPressed: () =>
                  telegramBotDownloadOption[DownloadOptionsKeys.onSubmit](
                    movie,
                  ),
              style: ButtonStyle(
                minimumSize: WidgetStatePropertyAll(Size(64, 64)),
                maximumSize: WidgetStatePropertyAll(Size(64, 64)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
