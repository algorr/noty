import 'package:noty/domain/core/failures.dart';

class AuthError extends Error {
  final ValueFailure valueFailure;

  AuthError(this.valueFailure);

  @override
  String toString() {
    return Error.safeToString(
        'Encountered error occured. Failure : $valueFailure');
  }
}
