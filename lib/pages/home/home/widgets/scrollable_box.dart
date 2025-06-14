import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';

class HomePageScrollableBox extends StatelessWidget {
  final String title;
  final List<Movie> items;
  final Widget Function(Movie movie) itemBuilder;

  const HomePageScrollableBox({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              CustomElevatedButton(
                text: "More",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    genericMoviesListRoute,
                    arguments: {"title": title, "movies": items},
                  );
                },
                variant: CustomElevatedButtonVariants.text,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          items.isNotEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(items.length, (index) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth * 0.65,
                            ),
                            child: itemBuilder(items[index]),
                          );
                        }),
                      ),
                    );
                  },
                )
              : const Center(child: CustomCircularProgressIndicator()),
        ],
      ),
    );
  }
}
