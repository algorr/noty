import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noty/app/auth/sign_in/sign_in_bloc.dart';
import 'package:noty/presentation/core/bezier_container.dart';
import 'package:noty/presentation/core/left_bezier_container.dart';
import 'package:noty/presentation/sign_in/widgets/custom_elevated_button.dart';
import 'package:noty/presentation/sign_in/widgets/custom_text_form_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              children: [
                _PositionedBezierContainer(size: size),
                _PositionedTitleText(size: size),
                Padding(
                  padding: EdgeInsets.only(top: size.height * .4),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width * .1, right: size.width * .1),
                      child: Form(
                          onChanged: () => state.showMessages,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextFormField(
                                hinText: 'Email',
                                prefixIcon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                onChanged: (value) {
                                  context
                                      .read<SignInBloc>()
                                      .add(SignInEvent.emailChanged(value));
                                },
                                validator: (_) => context
                                    .read<SignInBloc>()
                                    .state
                                    .emailAdress
                                    .value
                                    .fold(
                                        (f) => f.maybeMap(
                                            InvalidEmail: (_) =>
                                                'Invalid Email',
                                            orElse: () => null),
                                        (_) => null),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              CustomTextFormField(
                                hinText: 'Password',
                                prefixIcon: Icons.password,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                onChanged: (value) {
                                  context
                                      .read<SignInBloc>()
                                      .add(SignInEvent.passwordChanged(value));
                                },
                                validator: (_) => context
                                    .read<SignInBloc>()
                                    .state
                                    .password
                                    .value
                                   .fold(
                                        (f) => f.maybeMap(
                                            shortPassword: (_) =>
                                                'Short Password',
                                            orElse: () => null),
                                        (_) => null),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * .53,
                  left: size.width * .2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('If you do not have account'),
                            SizedBox(
                              width: size.width * .002,
                            ),
                            TextButton(
                                onPressed: () {}, child: Text('Sign Up!')),
                          ],
                        ),
                        CustomElevatedButton(
                          func: () {
                            context.read<SignInBloc>().add(SignInEvent.signInWithEmailAndPassword());
                          },
                          title: 'Sign In',
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: size.height * .1,
                    width: size.width * .3,
                    child: LeftBezierContainer(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PositionedTitleText extends StatelessWidget {
  const _PositionedTitleText({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: size.width * .1,
      top: size.width * .3,
      child: Text(
        'Sign In',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
      ),
    );
  }
}

class _PositionedBezierContainer extends StatelessWidget {
  const _PositionedBezierContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: SizedBox(
        height: size.height * .2,
        width: size.width * .2,
        child: BezierContainer(),
      ),
    );
  }
}
