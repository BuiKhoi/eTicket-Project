import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String _email, String _password);
  Future<String> signUp(String _email, String _password);
  Future<String> getCurrentUser();
  Future<void> signOut();
}

class FirebaseAuthentication implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid.toString();
  }

  @override
  Future<String> signIn(String _email, String _password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email,
        password: _password
    );
    return result.user.uid.toString();
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> signUp(String _email, String _password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    return result.user.uid.toString();
  }
}