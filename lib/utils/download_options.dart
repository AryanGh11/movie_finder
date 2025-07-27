import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum DownloadOptionsPopupValues { telegramBot, neterplay }

enum DownloadOptionsKeys { title, icon, onSubmit, buttonVariant, value }

final List<Map<DownloadOptionsKeys, dynamic>> downloadOptions = [
  {
    DownloadOptionsKeys.title: "Open movie in Neterplay",
    DownloadOptionsKeys.icon: Icons.movie,
    DownloadOptionsKeys.onSubmit: (Movie movie) => movie.openInNeterplay(),
    DownloadOptionsKeys.buttonVariant: CustomElevatedButtonVariants.primary,
    DownloadOptionsKeys.value: DownloadOptionsPopupValues.neterplay,
  },
  {
    DownloadOptionsKeys.title: "Open movie in Telegram Bot",
    DownloadOptionsKeys.icon: FontAwesomeIcons.telegram,
    DownloadOptionsKeys.onSubmit: (Movie movie) => movie.openInTelegramBot(),
    DownloadOptionsKeys.buttonVariant: CustomElevatedButtonVariants.outlined,
    DownloadOptionsKeys.value: DownloadOptionsPopupValues.telegramBot,
  },
];
