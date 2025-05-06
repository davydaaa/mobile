import 'package:flutter/material.dart';
import 'package:lab_1/repositories/local_user_repository.dart';
import 'package:lab_1/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _email = 'Unknown';
  final LocalUserRepository _userRepository = LocalUserRepository();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final email = await _userRepository.getCurrentUserEmail();
    setState(() {
      _email = email ?? 'Unknown';
    });
  }

  void _logout() async {
    await _userRepository.logout();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: $_email'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _logout, child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
