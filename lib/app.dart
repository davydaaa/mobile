import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String email;

  const MyApp({super.key, required this.isLoggedIn, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn ? HomeScreen(email: email) : const LoginScreen(),
    );
  }
}
