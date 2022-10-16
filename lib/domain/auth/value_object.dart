import 'package:dartz/dartz.dart';
import 'package:noty/domain/core/failures.dart';
import 'package:noty/domain/core/value_objects.dart';
import 'package:noty/domain/core/value_validators.dart';

class EmailAdress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAdress(String input) {
    return EmailAdress._(validateEmailAdress(input));
  }

  const EmailAdress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}
