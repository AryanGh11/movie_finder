import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: CustomCachedImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ),
    );
  }
}
