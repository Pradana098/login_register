import 'package:flutter/material.dart';
import 'login_page.dart'; // Ganti dengan path yang sesuai
import 'register_page.dart'; // Ganti dengan path yang sesuai
import 'profile_page.dart'; // Ganti dengan path yang sesuai

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Register Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
