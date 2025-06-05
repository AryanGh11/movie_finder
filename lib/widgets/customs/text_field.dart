import 'package:flutter/material.dart';

enum CustomTextFieldVariant { filled, outlined }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Widget? label;
  final String? hintText;
  final void Function(String value)? onChanged;
  final bool isPassword;
  final Widget? prefixIcon;
  final CustomTextFieldVariant? variant;

  const CustomTextField({
    required this.controller,
    super.key,
    this.label,
    this.hintText,
    this.onChanged,
    this.isPassword = false,
    this.prefixIcon,
    this.variant = CustomTextFieldVariant.filled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _removeText() {
    widget.controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // Outlined variant
    if (widget.variant == CustomTextFieldVariant.outlined) {
      return TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: widget.isPassword ? _obscureText : false,
        style: const TextStyle(),
        decoration: InputDecoration(
          label: widget.label,
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.all(20),
          suffixIcon: widget.isPassword
              ? Padding(
                  padding: const EdgeInsets.only(right: 10, left: 5),
                  child: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _toggleVisibility,
                  ),
                )
              : null,
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: widget.prefixIcon,
                )
              : null,
          prefixIconConstraints: BoxConstraints(minWidth: 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      );
    }

    // Filled variant (default)
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? _obscureText : false,
      style: const TextStyle(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        label: widget.label,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(20),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.only(right: 10, left: 5),
                child: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _toggleVisibility,
                ),
              )
            : widget.controller.text.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(right: 10, left: 5),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _removeText,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              )
            : null,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: widget.prefixIcon,
        ),
        alignLabelWithHint: true,
        prefixIconConstraints: BoxConstraints(minWidth: 0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
