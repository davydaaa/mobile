import 'package:flutter/material.dart';
import '../services/mqtt_service.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String temperature = 'Очікування...';

  @override
  void initState() {
    super.initState();
    MQTTService.listen((value) {
      setState(() {
        temperature = value;
      });
    });
    MQTTService.connect();
  }

  void _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Вийти?'),
        content: const Text('Ти впевнений що хочеш вийти?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Ні')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Так')),
        ],
      ),
    );

    if (confirmed ?? false) {
      await AuthService.logout();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Головна'),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Користувач: ${widget.email}'),
            const SizedBox(height: 20),
            Text('Температура: $temperature °C'),
          ],
        ),
      ),
    );
  }
}
