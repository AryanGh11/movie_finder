import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum DownloadOptionsPopupValues { telegramBot, neterplay }

enum DownloadOptionsKeys { title, icon, onSubmit, buttonVariant, value }

class DownloadOptions {
  static List<Map<DownloadOptionsKeys, dynamic>> _getOptions(
    BuildContext context,
  ) {
    return [
      {
        DownloadOptionsKeys.title: AppLocalizations.of(
          context,
        )!.openInNeterplay,
        DownloadOptionsKeys.icon: Icons.movie,
        DownloadOptionsKeys.onSubmit: (Movie movie) => movie.openInNeterplay(),
        DownloadOptionsKeys.buttonVariant: CustomElevatedButtonVariants.primary,
        DownloadOptionsKeys.value: DownloadOptionsPopupValues.neterplay,
      },
      {
        DownloadOptionsKeys.title: AppLocalizations.of(
          context,
        )!.openInTelegramBot,
        DownloadOptionsKeys.icon: FontAwesomeIcons.telegram,
        DownloadOptionsKeys.onSubmit: (Movie movie) =>
            movie.openInTelegramBot(),
        DownloadOptionsKeys.buttonVariant:
            CustomElevatedButtonVariants.outlined,
        DownloadOptionsKeys.value: DownloadOptionsPopupValues.telegramBot,
      },
    ];
  }

  static List<Map<DownloadOptionsKeys, dynamic>> getAll(BuildContext context) {
    final options = _getOptions(context);

    return options;
  }

  static Map<DownloadOptionsKeys, dynamic> getOne(
    BuildContext context, {
    required DownloadOptionsPopupValues query,
  }) {
    final options = _getOptions(context);

    final result = options.firstWhere(
      (option) => option[DownloadOptionsKeys.value] == query,
    );

    return result;
  }
}
