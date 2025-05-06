import 'package:flutter/material.dart';
import 'package:lab_1/repositories/local_user_repository.dart';
import 'package:lab_1/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final LocalUserRepository _userRepository = LocalUserRepository();

  String? _error;

  bool _validateInputs(String name, String email, String password) {
    if (!email.contains('@')) {
      setState(() => _error = 'Invalid email format');
      return false;
    }
    if (RegExp(r'\d').hasMatch(name)) {
      setState(() => _error = 'Name should not contain numbers');
      return false;
    }
    if (password.length < 6) {
      setState(() => _error = 'Password should be at least 6 characters');
      return false;
    }
    return true;
  }

  void _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    if (!_validateInputs(name, email, password)) return;

    await _userRepository.saveUser(email, password);
    if (!mounted) return;
    // ignore: inference_failure_on_instance_creation, lines_longer_than_80_chars
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ignore: lines_longer_than_80_chars
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
            // ignore: lines_longer_than_80_chars
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            // ignore: lines_longer_than_80_chars
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            // ignore: lines_longer_than_80_chars
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _register, child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}
