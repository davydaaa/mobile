import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BrandLogoScreen(),
    );
  }
}

class BrandLogoScreen extends StatefulWidget {
  const BrandLogoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrandLogoScreenState createState() => _BrandLogoScreenState();
}

class _BrandLogoScreenState extends State<BrandLogoScreen> {
  String? _logoPath;
  final TextEditingController _controller = TextEditingController();
  final Map<String, String> _brandLogos = {
    'nike': 'assets/nike.png',
    'adidas': 'assets/adidas.png',
    'apple': 'assets/apple.png',
    'google': 'assets/google.png',
    'carhartt': 'assets/carhartt.png',
    'dog': 'assets/dog.png',
  };

  void _showLogo() {
    final String input = _controller.text.trim().toLowerCase();
    setState(() {
      _logoPath = (input == 'none') ? null : _brandLogos[input];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brand Logo Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter brand name',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _showLogo,
              child: const Text('Show Logo'),
            ),
            const SizedBox(height: 20),
            // ignore: lines_longer_than_80_chars
            if (_logoPath != null) Image.asset(_logoPath!, width: 200, height: 200) else const Text('No logo found', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
