import 'package:dartz/dartz.dart';
import 'package:dbo_skin/domain/auth/auth_failure.dart';
import 'package:dbo_skin/domain/auth/email_address.dart';
import 'package:dbo_skin/domain/auth/password.dart';
import 'package:flutter/foundation.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {@required EmailAddress email, @required Password password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {@required EmailAddress email, @required Password password});

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
