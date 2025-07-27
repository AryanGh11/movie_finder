import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';

class SingleMovieScreenBottomNavigationBar extends StatelessWidget {
  final Movie movie;

  const SingleMovieScreenBottomNavigationBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 40, right: 16, left: 16),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: downloadOptions
            .map(
              (option) => CustomElevatedButton(
                prefixIcon: option[DownloadOptionsKeys.icon],
                text: option[DownloadOptionsKeys.title],
                onPressed: () => option[DownloadOptionsKeys.onSubmit](movie),
                variant: option[DownloadOptionsKeys.buttonVariant],
              ),
            )
            .toList(),
      ),
    );
  }
}
