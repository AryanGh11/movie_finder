import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/services/index.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<User> createWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw AuthException();
      }

      await userCredential.user!.updateDisplayName(displayName);
      await userCredential.user!.reload();

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } catch (e) {
      throw AuthException();
    }
  }

  static Future<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw AuthException();
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } catch (e) {
      throw AuthException();
    }
  }

  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return (await FirebaseAuth.instance.signInWithCredential(
        credential,
      )).user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } catch (e) {
      throw AuthException();
    }
  }

  static Future<User> changeDisplayName(String newDisplayName) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw AuthException();
      }

      await currentUser.updateDisplayName(newDisplayName);
      await currentUser.reload();

      return currentUser;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } catch (e) {
      throw AuthException();
    }
  }

  static Future<void> signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handle(e);
    } catch (e) {
      throw AuthException();
    }
  }
}
