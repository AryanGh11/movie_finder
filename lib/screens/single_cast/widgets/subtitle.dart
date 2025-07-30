import 'package:flutter/material.dart';

class SingleCastScreenSubtitle extends StatelessWidget {
  final String? text;

  const SingleCastScreenSubtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "Unknown",
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(125),
      ),
    );
  }
}
