import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/extensions/index.dart';

class ProfilePageInfoDialog extends StatefulWidget {
  final User fUser;
  final void Function(User user) onFUserUpdated;

  const ProfilePageInfoDialog({
    super.key,
    required this.fUser,
    required this.onFUserUpdated,
  });

  @override
  State<ProfilePageInfoDialog> createState() => _ProfilePageInfoDialogState();
}

class _ProfilePageInfoDialogState extends State<ProfilePageInfoDialog> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> infos = [
      {"title": "Email", "value": widget.fUser.email ?? "Unknown"},
      {"title": "Display name", "value": widget.fUser.displayName ?? "Unknown"},
      {"title": "Phone number", "value": widget.fUser.phoneNumber ?? "Unknown"},
      {
        "title": "EVS",
        "value": widget.fUser.emailVerified ? "Verified" : "Not verified",
      },
      {
        "title": "Created at",
        "value": widget.fUser.metadata.creationTime?.format() ?? "Unknown",
      },
      {
        "title": "Last sign in at",
        "value": widget.fUser.metadata.lastSignInTime?.format() ?? "Unknown",
      },
    ];

    return CustomDialog(
      title: "Info",
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(infos.length, (index) {
                  return Text(
                    infos[index]["title"]!,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(125),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(infos.length, (index) {
                  return Text(infos[index]["value"]!);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
