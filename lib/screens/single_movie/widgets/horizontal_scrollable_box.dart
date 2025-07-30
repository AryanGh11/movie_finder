import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/screens/single_movie/widgets/index.dart';

class SingleMovieScreenHorizontalScrollableBox extends StatelessWidget {
  final String? title;
  final List<Cast> items;
  final Widget Function(Cast cast) itemBuilder;
  final double itemWidthRatio;

  const SingleMovieScreenHorizontalScrollableBox({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.itemWidthRatio = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    return SingleMovieScreenLabelBox(
      title: title,
      body: items.isNotEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(items.length, (index) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * itemWidthRatio,
                        ),
                        child: itemBuilder(items[index]),
                      );
                    }),
                  ),
                );
              },
            )
          : const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 90),
                child: CustomCircularProgressIndicator(),
              ),
            ),
    );
  }
}
