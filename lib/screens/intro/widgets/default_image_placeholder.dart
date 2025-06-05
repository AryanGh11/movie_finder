import 'package:flutter/material.dart';

class IntroScreenDefaultImagePlaceholder extends StatelessWidget {
  const IntroScreenDefaultImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/intro_placeholder.webp",
      fit: BoxFit.cover,
    );
  }
}
