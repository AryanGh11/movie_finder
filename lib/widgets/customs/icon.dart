import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final Color? color;

  const CustomIcon({
    super.key,
    required this.path,
    this.width = 24,
    this.height = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }
}
