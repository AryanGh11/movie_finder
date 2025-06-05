import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/providers/local_user.dart';
import 'package:movie_finder/pages/home/widgets/index.dart';
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
    return HomePagePadding(
      child: Column(
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.fUser.displayName ?? "Unknown",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _openEditDisplayNameDialog,
                        icon: Icon(Icons.edit, size: 20),
                        constraints: BoxConstraints(minWidth: 0),
                      ),
                    ],
                  ),
                  Text(widget.fUser.phoneNumber ?? "Unknown"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
