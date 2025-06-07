import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final bool fullScreenOnTap;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.fullScreenOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fullScreenOnTap
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenImageViewer(imageUrl: imageUrl),
                ),
              );
            }
          : null,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          width: width,
          height: height,
          placeholder: (context, url) =>
              const Center(child: CustomCircularProgressIndicator()),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/default_poster.webp',
            fit: fit,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
