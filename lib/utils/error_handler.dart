import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_finder/services/index.dart';

class ErrorHandler {
  static void handle(Object error) {
    // Determine the error message
    String? message;
    if (error is AuthException) {
      message = error.message;
    } else {
      message = "There is something wrong. Please try again later.";
    }

    // Show a toast message
    Fluttertoast.showToast(
      msg: message ?? "An unknown error occurred",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red.shade400,
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}
