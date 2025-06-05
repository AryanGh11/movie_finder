import 'package:flutter/material.dart';

class HomePagePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const HomePagePadding({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.only(right: 20, left: 20, top: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}
