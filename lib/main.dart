import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MyHomePage.dart';
import 'NotificationService.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await NotificationService.initialize();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter"
      ),
      home:
      MyHomePage()
    );
  }
}

