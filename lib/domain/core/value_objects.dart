import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noty/domain/core/errors.dart';
import 'package:noty/domain/core/failures.dart';


@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

// throw Exception(AuthError) as ValueObject
  T crash(){
    return value.fold((l) => throw AuthError(l), id);
  }

  bool isValid() => value.isRight();

 @override
  bool operator ==(covariant ValueObject other) {
    if (identical(this, other)) return true;

    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}