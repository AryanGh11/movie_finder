import 'package:flutter/material.dart';

class SingleCastScreenLabelBox extends StatelessWidget {
  final String? title;
  final Widget body;

  const SingleCastScreenLabelBox({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          if (title != null)
            Text(
              title!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          body,
        ],
      ),
    );
  }
}
