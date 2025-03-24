import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BrandLogoScreen(),
    );
  }
}

class BrandLogoScreen extends StatefulWidget {
  @override
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
    String input = _controller.text.trim().toLowerCase();
    setState(() {
      _logoPath = (input == "none") ? null : _brandLogos[input];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Brand Logo Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter brand name',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _showLogo,
              child: Text('Show Logo'),
            ),
            SizedBox(height: 20),
            _logoPath != null
                ? Image.asset(_logoPath!, width: 200, height: 200)
                : Text('No logo found', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
