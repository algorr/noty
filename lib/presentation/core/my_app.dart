import 'package:flutter/material.dart';
import 'package:noty/presentation/sign_in/sign_in_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noty',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const SignInView(),
    );
  }
}