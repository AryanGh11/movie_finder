import 'package:flutter/material.dart';
import 'package:movie_finder/l10n/index.dart';

class InfiniteScrollableList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final Future<List<T>>? Function(int page) onLoadMore;
  final int itemInRowCount;
  final double itemHeightRatio;

  const InfiniteScrollableList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    this.itemInRowCount = 2,
    this.itemHeightRatio = 1.65,
  });

  @override
  State<InfiniteScrollableList> createState() =>
      _InfiniteScrollableListState<T>();
}

class _InfiniteScrollableListState<T> extends State<InfiniteScrollableList> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 300.0;

  List<T> _localItems = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _localItems = List<T>.from(widget.items);
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant InfiniteScrollableList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items && _page == 1) {
      _localItems = List<T>.from(widget.items);
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _isLoading || !_hasMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoading = true);
    final newItems = await widget.onLoadMore(_page + 1);
    setState(() {
      if (newItems != null && newItems.isEmpty) {
        _hasMore = false;
      } else {
        _page++;
        _localItems.addAll((newItems ?? []).cast<T>());
      }
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = 20.0;
    final spacing = 0.0;
    final totalHorizontalSpacing = (horizontalPadding * 2) + spacing;

    // Calculate width of each card (2 columns)
    final itemWidth =
        (screenWidth - totalHorizontalSpacing) / widget.itemInRowCount;

    // Define a fixed or responsive height (based on image or design)
    final itemHeight = itemWidth * widget.itemHeightRatio;
    final aspectRatio = itemWidth / itemHeight;

    return _localItems.isNotEmpty
        ? CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return widget.itemBuilder(_localItems[index]);
                }, childCount: _localItems.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.itemInRowCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: aspectRatio,
                ),
              ),
              SliverToBoxAdapter(
                child: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink(),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
            ],
          )
        : Center(child: Text(AppLocalizations.of(context)!.dataNotFound));
  }
}
