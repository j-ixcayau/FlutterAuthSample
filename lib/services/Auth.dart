import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
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

    if (result == null ||
        result.accessToken == null ||
        result.accessToken.token == null) return null;

    AuthCredential authCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    if (authCredential == null) return null;

    return await _firebaseAuth.signInWithCredential(authCredential);
  }

  Future<UserCredential> loginGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserCredential> loginTwitter() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: "JKomrf1RtbGcHKxb4w6arj6mQ",
      consumerSecret: "uooktNIjScTPDhOifO51yV2fqMFdda88l92aE3wYeycc3FHnu5",
    );

    final TwitterLoginResult result = await twitterLogin.authorize();

    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: result.session.token, secret: result.session.secret);
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

/*   Future<UserCredential> loginTwitter() async {
    var uri = Uri.https(
        "https://authsample-4fd39.firebaseapp.com/__/auth/handler", "");

    var twitterLogin = TwitterLogin(
      apiKey: "JKomrf1RtbGcHKxb4w6arj6mQ",
      apiSecretKey: "uooktNIjScTPDhOifO51yV2fqMFdda88l92aE3wYeycc3FHnu5",
      redirectURI: "https://authsample-4fd39.firebaseapp.com/__/auth/handler",
    );

    final AuthResult authResult = await twitterLogin.login();

    if (authResult == null || authResult.status == TwitterLoginStatus.error)
      return null;

    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken, secret: authResult.authTokenSecret);

    if (twitterAuthCredential == null) return null;

    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  } */

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Stream<User> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
