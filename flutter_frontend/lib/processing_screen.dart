import 'package:flutter/material.dart';
import 'caption_screen.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
   @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return; // ✅ Fix: Check if the widget is still in the tree
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CaptionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 242, 230, 227),
      appBar: AppBar(title: const Text('Processing'),backgroundColor:Color.fromARGB(255, 242, 230, 227)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Vertical centering
        crossAxisAlignment: CrossAxisAlignment.center, // Horizontal centering
        children: [
          const CircularProgressIndicator(color:Color.fromARGB(255, 213, 72, 40)),
          const SizedBox(height: 20),
          const Text('Processing your image...'),
        ],
      ),
    );
  }
}
