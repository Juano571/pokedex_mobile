import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> loginWithEmailPassword(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      _isAuthenticated = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _isAuthenticated = false;
      if (e.code == 'user-not-found') {
        print('No user found for that email');
      }
    }
    notifyListeners();
  }
}
