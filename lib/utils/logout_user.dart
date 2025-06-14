import 'package:flutter/material.dart';
import 'package:movie_finder/utils/index.dart';
import 'package:movie_finder/services/index.dart';

class LogoutUser {
  static Future<void> logout(BuildContext context) async {
    await AuthService.signOut();
    Navigator.of(
      // ignore: use_build_context_synchronously
      context,
    ).pushNamedAndRemoveUntil(introRoute, (route) => false);
  }
}
