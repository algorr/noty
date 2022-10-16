import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:noty/domain/auth/auth_failure.dart';
import 'package:noty/domain/auth/i_auth_face.dart';
import 'package:noty/domain/auth/value_object.dart';

@LazySingleton(as: IAuthFace)
class FirebaseAuthFace implements IAuthFace {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFace(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required EmailAdress emailAdress, required Password password}) async {
    final emailAdressString = emailAdress.crash();
    final passwordString = password.crash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAdressString, password: passwordString);
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      }
      return left(const AuthFailure.serverError());
    }
    return right(unit);
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required EmailAdress emailAdress, required Password password}) async {
    final emailAdressString = emailAdress.crash();
    final passwordString = password.crash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAdressString, password: passwordString);
    } on PlatformException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'wrong-password') {
        return left(const AuthFailure.wrongEmailAndPassword());
      }
      return left(const AuthFailure.serverError());
    }
    return right(unit);
  }

  @override
  Future<Either<AuthFailure, Unit>> signWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuth = await googleUser.authentication;

      final googleAuthCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      return _firebaseAuth
          .signInWithCredential(googleAuthCredential)
          .then((r) => right(unit));
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }
}
