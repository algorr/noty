import 'package:dartz/dartz.dart';
import 'package:noty/domain/auth/auth_failure.dart';
import 'package:noty/domain/auth/value_object.dart';

abstract class IAuthFace {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAdress emailAdress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAdress emailAdress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signWithGoogle();
}
