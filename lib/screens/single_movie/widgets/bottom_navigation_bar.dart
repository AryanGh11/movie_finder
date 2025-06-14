import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SingleMovieScreenBottomNavigationBar extends StatelessWidget {
  final Movie movie;

  const SingleMovieScreenBottomNavigationBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
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
                        await movie.openInGoogle(GoogleLangs.persian),
                    variant: CustomElevatedButtonVariants.outlined,
                  ),
                  CustomElevatedButton(
                    text: "in English",
                    onPressed: () async =>
                        await movie.openInGoogle(GoogleLangs.english),
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
            onPressed: movie.openInTelegramBot,
          ),
        ],
      ),
    );
  }
}
