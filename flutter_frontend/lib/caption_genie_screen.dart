import 'package:flutter/material.dart';
import 'home_screen.dart';

class CaptionGenieScreen extends StatelessWidget {
  const CaptionGenieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 242, 230, 227) ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Icon(Icons.image, size: 100, color:Color.fromARGB(255, 213, 72, 40)),
          const Text(
            'CaptionGenie',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Text('Generate Captions from Your Images'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 213, 72, 40),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              child: const Text('Get Started', style :TextStyle(color: Color.fromARGB(255, 237, 234, 234))),
            ),
          ),
        ],
      ),
    );
  }
}
