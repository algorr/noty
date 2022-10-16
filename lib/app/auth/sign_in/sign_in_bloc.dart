import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:noty/domain/auth/auth_failure.dart';
import 'package:noty/domain/auth/i_auth_face.dart';
import 'package:noty/domain/auth/value_object.dart';
import 'package:noty/domain/core/failures.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final IAuthFace _authFace;
  SignInBloc(this._authFace) : super(SignInState.initial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAdress: EmailAdress(e.emailString),
          authFailureOrSuccessOption: none(),
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          emailAdress: EmailAdress(e.passwordString),
          authFailureOrSuccessOption: none(),
        );
      },
      registerWithEmailAndPassword: (e) async* {
       yield* _pushWhichFunctionPrefer(_authFace.registerWithEmailAndPassword);
      },
      signInWithEmailAndPassword: (e) async* {
        yield* _pushWhichFunctionPrefer(_authFace.signInWithEmailAndPassword);
      },
      signInWithGoogle: (e) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        );
        final result = await _authFace.signWithGoogle();
        yield state.copyWith(
            isSubmitting: false, authFailureOrSuccessOption: some(result));
      },
    );
  }

  Stream<SignInState> _pushWhichFunctionPrefer(Future<Either<AuthFailure,Unit>> Function({
    required EmailAdress emailAdress,required Password password,
  }) preferFunction) async*{
     Either<AuthFailure, Unit> result;
        final isEmailValid = state.emailAdress.isValid();
        final isPasswordValid = state.password.isValid();
        if (isEmailValid && isPasswordValid) {
          yield state.copyWith(
              isSubmitting: true, authFailureOrSuccessOption: none());

          result = await preferFunction(
              emailAdress: state.emailAdress, password: state.password);

          yield state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: optionOf(result));
        }

        yield state.copyWith(
            showMessages: true, authFailureOrSuccessOption: none());
  }
}
