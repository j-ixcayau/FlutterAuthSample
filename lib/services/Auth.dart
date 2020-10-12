import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<UserCredential> loginGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Stream<User> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
