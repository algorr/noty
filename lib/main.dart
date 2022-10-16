import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:noty/injection.dart';
import 'package:noty/presentation/core/my_app.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  configureInjection(Environment.prod);
  runApp(const MyApp());
}



