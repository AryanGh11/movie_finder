import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/providers/index.dart';
import 'package:movie_finder/pages/home/profile/widgets/index.dart';

class ProfilePage extends StatefulWidget {
  final User fUser;
  final LocalUserProvider localUser;
  final void Function(User user) onFUserUpdated;

  const ProfilePage({
    super.key,
    required this.fUser,
    required this.localUser,
    required this.onFUserUpdated,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _openEditDisplayNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProfilePageEditDisplayNameDialog(
        fUser: widget.fUser,
        onFUserUpdated: widget.onFUserUpdated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Column(
          spacing: 10,
          children: [
            CustomCachedImage(
              imageUrl: widget.fUser.photoURL ?? "",
              width: 128,
              height: 128,
              borderRadius: BorderRadius.circular(99999),
            ),
            Column(
              spacing: 5,
              children: [
                Text(
                  widget.fUser.displayName ?? "Unknown",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.fUser.phoneNumber ?? "Unknown",
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(125),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfilePageActionCard(
                label: "Edit",
                icon: Icons.edit,
                onTap: _openEditDisplayNameDialog,
              ),
              ProfilePageActionCard(
                label: "User info",
                icon: Icons.info,
                onTap: () {},
              ),
              ProfilePageActionCard(
                label: "Log out",
                icon: Icons.logout,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
