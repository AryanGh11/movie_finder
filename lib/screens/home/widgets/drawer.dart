import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/providers/index.dart';

class HomeScreenDrawer extends StatelessWidget {
  final User user;
  final void Function(int index) onNavigationTap;

  const HomeScreenDrawer({
    super.key,
    required this.user,
    required this.onNavigationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              CustomCachedImage(
                imageUrl: "",
                width: double.infinity,
                height: 200,
                borderRadius: BorderRadius.zero,
                fullScreenOnTap: false,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  user.displayName ?? "Unknown",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pop(context);
              onNavigationTap(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await LocalUserProvider().logout(context);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
