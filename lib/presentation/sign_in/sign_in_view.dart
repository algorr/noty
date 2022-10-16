import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noty/app/auth/sign_in/sign_in_bloc.dart';
import 'package:noty/injection.dart';
import 'package:noty/presentation/sign_in/widgets/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInBloc>(
        create: (context) => getIt<SignInBloc>(),
        child: SignInForm(),
      ),
    );
  }
}
