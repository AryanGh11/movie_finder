import 'package:flutter/material.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';

class MoviePageVerticalScrollableBox extends StatelessWidget {
  final String title;
  final List<Movie> items;
  final Widget Function(Movie movie) itemBuilder;
  final double? height;

  const MoviePageVerticalScrollableBox({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width / 2.5;
    final double cardHeight = (cardWidth * 9) / 16;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                // todo
                onPressed: () {},
                variant: CustomElevatedButtonVariants.text,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          items.isNotEmpty
              ? SizedBox(
                  height: height ?? ((cardHeight + 20) * 4),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(),
                    itemBuilder: (context, index) {
                      return itemBuilder(items[index]);
                    },
                  ),
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 90),
                    child: CustomCircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }
}
