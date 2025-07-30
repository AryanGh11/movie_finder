import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/models/index.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:movie_finder/constants/index.dart';
import 'package:movie_finder/pages/home/cast/bloc/index.dart';
import 'package:movie_finder/pages/home/cast/widgets/index.dart';

class CastPage extends StatefulWidget {
  final bool isSearchTextFieldVisible;

  const CastPage({super.key, required this.isSearchTextFieldVisible});

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String? _prevQuery;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged() {
    final HomeScreenCastBloc homeBloc = context.read<HomeScreenCastBloc>();

    if (_debounce != null) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();

      if (query.isNotEmpty) {
        if (_prevQuery != query) {
          homeBloc.add(SearchCast(query));
          setState(() {
            _prevQuery = query;
          });
        }
      } else {
        // Only go back to FetchCast if the bloc is currently in a searched state
        final state = homeBloc.state;
        if (state is HomeScreenCastSearchResult ||
            state is HomeScreenCastLoading) {
          context.read<HomeScreenCastBloc>().add(FetchCast());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: widget.isSearchTextFieldVisible
              ? CustomTextField(
                  controller: _searchController,
                  hintText: "Search for cast ...",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomIcon(
                      path: IconsPaths.search,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          child: BlocBuilder<HomeScreenCastBloc, HomeScreenCastState>(
            builder: (context, state) {
              // Provide empty or real lists depending on state
              final searchedCast = state is HomeScreenCastSearchResult
                  ? state.results
                  : <Cast>[];
              final popularCast = state is HomeScreenCastLoaded
                  ? state.popular
                  : <Cast>[];

              if (state is HomeScreenCastLoading) {
                return Center(child: CustomCircularProgressIndicator());
              }

              return CastPageContent(
                popularCast: popularCast,
                searchedCast: searchedCast,
                searchController: _searchController,
              );
            },
          ),
        ),
      ],
    );
  }
}
