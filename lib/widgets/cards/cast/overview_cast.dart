import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';

class OverviewCastCard extends StatelessWidget {
  final Cast cast;

  const OverviewCastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => {
          Navigator.pushNamed(context, singleCastRoute, arguments: cast.id),
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            spacing: 8,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: CustomCachedImage(
                  imageUrl: cast.profilePath ?? '',
                  fullScreenOnTap: false,
                ),
              ),
              Column(
                children: [
                  Text(
                    cast.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    cast.popularity.toString(),
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
