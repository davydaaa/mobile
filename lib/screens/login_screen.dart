import 'package:flutter/material.dart';
import 'package:lab_1/repositories/local_user_repository.dart';
import 'package:lab_1/screens/home_screen.dart';
import 'package:lab_1/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LocalUserRepository _userRepository = LocalUserRepository();

  String? _error;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final success = await _userRepository.login(email, password);
    if (success) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      setState(() => _error = 'Invalid email or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ignore: lines_longer_than_80_chars
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            // ignore: lines_longer_than_80_chars
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            // ignore: lines_longer_than_80_chars
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            TextButton(
              // ignore: inference_failure_on_instance_creation, lines_longer_than_80_chars
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
