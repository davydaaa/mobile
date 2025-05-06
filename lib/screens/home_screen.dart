import 'package:flutter/material.dart';
import 'package:lab_1/screens/profile_screen.dart'; // Імпортуємо екран профілю

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, bool> deviceStates = {
    'Light': false,
    'AC': false,
    'Lock': false,
    'TV': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                // ignore: inference_failure_on_instance_creation
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Connected Devices',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: deviceStates.keys.map((device) {
                  final bool isOn = deviceStates[device]!;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        deviceStates[device] = !isOn;
                      });
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isOn ? Colors.green : Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          // ignore: lines_longer_than_80_chars
                          const BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getDeviceIcon(device),
                            size: 50,
                            color: isOn ? Colors.white : Colors.black87,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            device,
                            // ignore: lines_longer_than_80_chars
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isOn ? Colors.white : Colors.black),
                          ),
                          Text(
                            isOn ? 'ON' : 'OFF',
                            // ignore: lines_longer_than_80_chars
                            style: TextStyle(fontSize: 14, color: isOn ? Colors.white : Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDeviceIcon(String device) {
    switch (device) {
      case 'Light':
        return Icons.lightbulb;
      case 'AC':
        return Icons.ac_unit;
      case 'Lock':
        return Icons.lock;
      case 'TV':
        return Icons.tv;
      default:
        return Icons.device_unknown;
    }
  }
}
