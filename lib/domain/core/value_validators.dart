import 'package:dartz/dartz.dart';
import 'package:noty/domain/core/failures.dart';


Either<ValueFailure<String>, String> validateEmailAdress(String input){
     const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
          if (RegExp(emailRegex).hasMatch(input)) {
        return right(input);
      }
      return left(ValueFailure.InvalidEmail(failedValue: input));
}


Either<ValueFailure<String>, String> validatePassword(String input){
    if (input.length >= 6) {
      return right(input);
    }
        return left(ValueFailure.shortPassword(failedValue: input));

    
}