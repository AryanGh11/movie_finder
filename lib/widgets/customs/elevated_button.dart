import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';

enum CustomElevatedButtonVariants { primary, outlined, text }

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final IconData? prefixIcon;
  final VoidCallback? onPressed;
  final CustomElevatedButtonVariants variant;
  final bool loading;
  final Color? color;

  const CustomElevatedButton({
    required this.text,
    this.prefixIcon,
    required this.onPressed,
    this.variant = CustomElevatedButtonVariants.primary,
    this.loading = false,
    this.color,
    super.key,
  });

  get textWidget {
    return Text(text.toUpperCase(), style: const TextStyle(fontSize: 16));
  }

  Widget _buildChild(BuildContext context) {
    // Loading
    if (loading == true) {
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 20,
          height: 20,
          child: CustomCircularProgressIndicator(),
        ),
      );
    }

    // With icon
    if (prefixIcon != null) {
      return Row(
        children: [
          Icon(prefixIcon, size: 20),
          Expanded(child: Center(child: textWidget)),
        ],
      );
    }

    return Row(
      children: [Expanded(child: Center(child: textWidget))],
    );
  }

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnPressed = loading ? null : onPressed;

    // Text variant
    if (variant == CustomElevatedButtonVariants.text) {
      return ElevatedButton(
        onPressed: effectiveOnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(0, 0), // Use to set height of content
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: color,
          ),
        ),
      );
    }

    // Outlined variant
    if (variant == CustomElevatedButtonVariants.outlined) {
      return SizedBox(
        height: 62,
        child: ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.surface,
            ),
            foregroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
            elevation: WidgetStatePropertyAll(0),
            overlayColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.onSurface.withAlpha(10),
            ),
          ),
          child: _buildChild(context),
        ),
      );
    }

    // Primary variant
    return SizedBox(
      height: 62,
      child: ElevatedButton(
        onPressed: effectiveOnPressed,
        child: _buildChild(context),
      ),
    );
  }
}
