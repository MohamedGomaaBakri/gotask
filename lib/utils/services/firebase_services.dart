import 'dart:developer';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/utils/errors/exeptions.dart';

class FirebaseServices
{
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async
  {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception on firebaseAuthServices.createUserWithEmailAndPassword: ${e.code}');
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: 'The account already exists for that email.');
      }else
      {
        throw CustomException(message: 'Something went wrong. Please try again.');
      }
    } catch (e) {
      log('Exception on firebaseAuthServices.createUserWithEmailAndPassword: $e');
      throw CustomException(message: 'Something went wrong. Please try again.');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async
  {
    try {
       
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (credential.user!.emailVerified) {
          return credential.user!;
        }else
        {
          throw CustomException(message: 'Please verify your email first.');
        }
      
    } on FirebaseAuthException catch (e) {
      log('Exception on firebaseAuthServices.signInWithEmailAndPassword: ${e.code}');
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'Wrong password provided for that user.');
      }else if (e.code == 'invalid-credential') {
        throw CustomException(message: 'Invalid user. Please try again.');
      }
      else
      {
        throw CustomException(message: 'Something went wrong. Please try again.');
      }
    } catch (e) {
      if(e.toString() == 'we send verification email. Please verify your email first.')
      {
        throw CustomException(message: 'Please verify your email first.');
      }
      log('Exception on firebaseAuthServices.signInWithEmailAndPassword: $e');
      throw CustomException(message: 'Something went wrong. Please try again.');
    }
  }

  Future<User> signInWithGoogle() async
  {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User> signInWithFacaBook() async
  {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return (await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user!;
  }
}