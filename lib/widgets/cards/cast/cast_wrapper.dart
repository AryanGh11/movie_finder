import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';

class CastCardWrapper extends StatelessWidget {
  final Widget child;
  final Cast movie;

  const CastCardWrapper({super.key, required this.child, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(context, singleCastRoute, arguments: movie.id);
          },
          child: Padding(padding: const EdgeInsets.all(5), child: child),
        ),
      ),
    );
  }
}
