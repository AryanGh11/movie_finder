import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  final String? message;
  AuthException({this.message});

  @override
  String toString() =>
      'AuthException: ${message ?? "An unknown error occurred"}';
}

class FirebaseAuthExceptionHandler {
  static AuthException handle(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return AuthException(message: "E-Mail is already in use.");
      case 'invalid-email':
        return AuthException(message: "E-Mail is invalid.");
      case 'user-disabled':
        return AuthException(message: "This user account has been disabled.");
      case 'user-not-found':
        return AuthException(message: "No user found with this email.");
      case 'wrong-password':
        return AuthException(message: "Incorrect password.");
      case 'weak-password':
        return AuthException(
          message: "Password must be at least 6 characters.",
        );
      case 'invalid-credential':
        return AuthException(message: "Credential is invalid.");
      case 'too-many-requests':
        return AuthException(
          message: "Too many attempts. Please try again later.",
        );
      default:
        return AuthException(
          message: "An unknown error occurred: ${e.message}",
        );
    }
  }
}
