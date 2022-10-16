part of 'sign_in_bloc.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    required EmailAdress emailAdress,
    required Password password,
    required bool showMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _SignInState;

  factory SignInState.initial() => SignInState(
        emailAdress: EmailAdress(''),
        password: Password(''),
        showMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}
