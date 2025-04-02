import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // ignore: lines_longer_than_80_chars
      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
      child: Text(text),
    );
  }
}
