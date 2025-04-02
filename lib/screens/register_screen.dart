import 'package:flutter/material.dart';
import 'package:lab_1/widgets/custom_button.dart';
import 'package:lab_1/widgets/text_input_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextInputField(hintText: 'Email'),
            const SizedBox(height: 16),
            const TextInputField(hintText: 'Password', obscureText: true),
            const SizedBox(height: 16),
            CustomButton(text: 'Register', onPressed: () => Navigator.pushNamed(context, '/home')),
          ],
        ),
      ),
    );
  }
}
