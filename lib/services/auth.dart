import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> authStatusControl() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> createUserWithEmail(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userCredential.user!.updateDisplayName(username);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
