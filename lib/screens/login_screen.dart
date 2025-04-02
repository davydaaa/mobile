import 'package:flutter/material.dart';
import 'package:lab_1/widgets/custom_button.dart';
import 'package:lab_1/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextInputField(hintText: 'Email'),
            const SizedBox(height: 16),
            const TextInputField(hintText: 'Password', obscureText: true),
            const SizedBox(height: 16),
            CustomButton(text: 'Login', onPressed: () => Navigator.pushNamed(context, '/home')),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
