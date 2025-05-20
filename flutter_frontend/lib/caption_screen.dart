import 'package:flutter/material.dart';

class CaptionScreen extends StatefulWidget {
  final String caption;

  const CaptionScreen({super.key, required this.caption});

  @override
  State<CaptionScreen> createState() => _CaptionScreenState();
}

class _CaptionScreenState extends State<CaptionScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode
          ? const Color.fromARGB(255, 30, 30, 30) // Dark Mode BG
          : const Color.fromARGB(255, 242, 230, 227), // Light Mode BG
      appBar: AppBar(
        title: const Text('Caption'),
        backgroundColor: _isDarkMode
            ? const Color.fromARGB(255, 30, 30, 30)
            : const Color.fromARGB(255, 242, 230, 227),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.caption,
              style: TextStyle(
                fontSize: 18,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}