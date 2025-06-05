import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IMDB extends StatelessWidget {
  final String? imdbId;

  const IMDB({super.key, required this.imdbId});

  @override
  Widget build(BuildContext context) {
    final String imdbLink = 'https://www.imdb.com/title/$imdbId';

    Future<void> openInBrowser() async {
      final Uri url = Uri.parse(imdbLink);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text('Cannot launch URL')));
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
