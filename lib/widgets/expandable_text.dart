import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 2,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  bool _hasOverflow = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkOverflow();
  }

  void _checkOverflow() {
    final textSpan = TextSpan(text: widget.text, style: const TextStyle());
    final tp = TextPainter(
      text: textSpan,
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 32);

    _hasOverflow = tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hasOverflow ? () => setState(() => _expanded = !_expanded) : null,
      child: Text(
        widget.text,
        style: widget.style,
        maxLines: _expanded ? null : widget.trimLines,
        overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
  }
}
