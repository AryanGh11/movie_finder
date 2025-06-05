import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/models/hive/index.dart';

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
                onPressed: () {},
                variant: CustomElevatedButtonVariants.text,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: items.isNotEmpty
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 15),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: itemBuilder(items[index]),
                      );
                    },
                  )
                : const Center(child: CustomCircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
