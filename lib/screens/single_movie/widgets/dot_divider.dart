import 'package:flutter/material.dart';

class SingleMovieScreenDotDivider extends StatelessWidget {
  const SingleMovieScreenDotDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(125),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
