import 'package:flutter/material.dart';

class RatingStars extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const RatingStars({super.key, required this.value, required this.onChanged});

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  late double currentRating;

  @override
  void initState() {
    super.initState();
    currentRating = widget.value;
  }

  void _updateRating(double newRating) {
    setState(() {
      currentRating = newRating;
    });
    widget.onChanged(currentRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final starPosition = index + 1;
        IconData icon;

        if (currentRating >= starPosition) {
          icon = Icons.star; // Full
        } else if (currentRating >= starPosition - 0.5) {
          icon = Icons.star_half; // Half
        } else {
          icon = Icons.star_border; // Empty
        }

        return GestureDetector(
          onTap: () => _updateRating(starPosition.toDouble()),
          onDoubleTap: () => _updateRating(starPosition - 0.5),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        );
      }),
    );
  }
}
