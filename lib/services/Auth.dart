import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Auth {
  Auth() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  FirebaseAuth _firebaseAuth;

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String pass) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String pass) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
  }

  Future<UserCredential> loginFacebook() async {
    final FacebookLoginResult result = await FacebookLogin().logIn(['email']);

    AuthCredential authCredential =
        FacebookAuthProvider.credential(result.accessToken.token);
    return await _firebaseAuth.signInWithCredential(authCredential);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Stream<User> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
