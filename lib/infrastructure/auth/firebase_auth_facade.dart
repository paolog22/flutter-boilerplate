import 'package:dbo_skin/domain/auth/email_address.dart';
import 'package:dbo_skin/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dbo_skin/domain/auth/i_auth_facade.dart';
import 'package:dbo_skin/domain/auth/password.dart';
import 'package:dbo_skin/domain/core/error.dart';
import 'package:flutter/services.dart';

class FirebaseAuthFacade implements IAuthFacade {
  // have dependency inject here ex. firebase auth

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  }) async {
    final emailAddStr = email.getOrFail();
    final passwordStr = password.getOrFail();

    try {
      // call inject dependecy method here for ex: firebase auth
      await _dep.createUserWithEmail(emailAddStr, passwordStr);
      return right(unit);
    } on PlatformException catch (e) {
      return left(const AuthFailure.emailAlreadyExist());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  }) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
  // have a firebase inject here
}
