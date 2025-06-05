import 'package:flutter/material.dart';

class AppTitleIcon extends StatelessWidget {
  final void Function()? onTap;

  const AppTitleIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: 10,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/icon/app_icon.png",
              width: 30,
              height: 30,
            ),
          ),
          const Text(
            "Movie Finder",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
