import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/screens/single_cast/widgets/index.dart';

class SingleCastScreenContent extends StatelessWidget {
  final Cast cast;

  const SingleCastScreenContent({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                cast.name,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // Information
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10,
                  children: [
                    SingleCastScreenSubtitle(
                      text: cast.birthday != null
                          ? '${DateFormat.yMMMMd().format(cast.birthday!)} (${cast.age} y.o)'
                          : null,
                    ),
                    DotDivider(),
                    Row(
                      spacing: 2,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 18,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.25),
                        ),
                        SingleCastScreenSubtitle(
                          text: cast.popularity.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tabs
              SizedBox(
                child: TabBar(
                  unselectedLabelColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha(125),
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Movies'),
                  ],
                ),
              ),

              SizedBox(height: 5),

              // Tabs' children
              SizedBox(
                height: 300,
                child: TabBarView(
                  children: [
                    // About Tab
                    if (cast.biography != null)
                      Column(
                        children: [
                          ExpandableText(
                            text: cast.biography!,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha(125),
                            ),
                          ),
                          Row(
                            children: [
                              Text('Birth-place: ${cast.placeOfBirth}'),
                            ],
                          ),
                        ],
                      ),

                    // Movie Tab
                    cast.movies != null
                        ? SingleCastScreenMovies(movies: cast.movies!)
                        : Center(
                            child: Text(
                              AppLocalizations.of(context)!.noCastAvailable,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
