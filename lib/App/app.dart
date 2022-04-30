import 'package:flutter/material.dart';
import '../features/Auth/pages/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grateful',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const AuthGate(),
    );
  }
}
