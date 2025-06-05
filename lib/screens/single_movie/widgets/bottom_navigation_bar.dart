import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/services/telegram_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum GoogleLangs { persian, english }

class SingleMovieScreenBottomNavigationBar extends StatelessWidget {
  final Movie movie;

  const SingleMovieScreenBottomNavigationBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    void openMovieInTelegramBot() async {
      await TelegramService.sendMessage(
        message: movie.imdbId ?? movie.title,
        username: "DonyayeSerialBot",
      );
    }

    Future<void> openMovieInGoogle(GoogleLangs lang) async {
      final String searchQuery = lang == GoogleLangs.persian
          ? "دانلود فیلم ${movie.title} بدون سانسور"
          : "Download ${movie.title} for free";
      final Uri url = Uri.parse("https://www.google.com/search?q=$searchQuery");

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch Telegram';
      }
    }

    void openSearchInGoogleDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Search in Google",
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton(
                    text: "in Persian",
                    onPressed: () async =>
                        await openMovieInGoogle(GoogleLangs.persian),
                    variant: CustomElevatedButtonVariants.outlined,
                  ),
                  CustomElevatedButton(
                    text: "in English",
                    onPressed: () async =>
                        await openMovieInGoogle(GoogleLangs.english),
                    variant: CustomElevatedButtonVariants.outlined,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 40, right: 16, left: 16),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            variant: CustomElevatedButtonVariants.outlined,
            prefixIcon: FontAwesomeIcons.google,
            text: "Search in Google",
            onPressed: openSearchInGoogleDialog,
          ),
          CustomElevatedButton(
            prefixIcon: FontAwesomeIcons.telegram,
            text: "Search in Telegram Bot",
            onPressed: openMovieInTelegramBot,
          ),
        ],
      ),
    );
  }
}
