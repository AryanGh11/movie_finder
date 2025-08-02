// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';
import 'package:url_launcher/url_launcher.dart';

enum IMDBType { movie, cast }

class IMDB extends StatelessWidget {
  final String? imdbId;
  final IMDBType type;

  const IMDB({super.key, required this.imdbId, this.type = IMDBType.movie});

  @override
  Widget build(BuildContext context) {
    final String imdbLink =
        'https://www.imdb.com/${type == IMDBType.movie ? "title" : "name"}/$imdbId';

    Future<void> openInBrowser() async {
      final Uri url = Uri.parse(imdbLink);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.cannotLaunchUrl),
          ),
        );
      }
    }

    return IconButton(
      onPressed: imdbId != null ? openInBrowser : null,
      icon: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "IMDB",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
