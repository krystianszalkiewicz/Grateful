import 'package:flutter/material.dart';
import '../features/Auth/pages/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grateful',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xEDEBE8E8),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.yellow,
              primary: Colors.blue),
        ),
        primarySwatch: Colors.yellow,
      ),
      home: const AuthGate(),
    );
  }
}
