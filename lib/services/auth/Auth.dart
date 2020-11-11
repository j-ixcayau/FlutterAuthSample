import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:github_sign_in/github_sign_in.dart';
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
        result.status == FacebookLoginStatus.cancelledByUser ||
        result.status == FacebookLoginStatus.error) return null;

    AuthCredential authCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    if (authCredential == null) return null;

    return await _firebaseAuth.signInWithCredential(authCredential);
  }

  Future<UserCredential> loginGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<UserCredential> loginTwitter() async {
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: "JKomrf1RtbGcHKxb4w6arj6mQ",
      consumerSecret: "uooktNIjScTPDhOifO51yV2fqMFdda88l92aE3wYeycc3FHnu5",
    );

    final TwitterLoginResult result = await twitterLogin.authorize();

    if (result == null ||
        result.status == TwitterLoginStatus.cancelledByUser ||
        result.status == TwitterLoginStatus.error) return null;

    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: result.session.token, secret: result.session.secret);

    return await _firebaseAuth.signInWithCredential(twitterAuthCredential);
  }

  Future<UserCredential> loginGithub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: "ef02311ad2c50fc4117b",
      clientSecret: "989152ba1ebb5433e9cf971a1c58411ef2b2e26b",
      redirectUrl: "https://authsample-4fd39.firebaseapp.com/__/auth/handler",
    );

    final GitHubSignInResult result = await gitHubSignIn.signIn(context);

    if (result == null ||
        result.status == GitHubSignInResultStatus.cancelled ||
        result.status == GitHubSignInResultStatus.failed) return null;

    final AuthCredential githubCredential =
        GithubAuthProvider.credential(result.token);

    return await _firebaseAuth.signInWithCredential(githubCredential);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Stream<User> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
