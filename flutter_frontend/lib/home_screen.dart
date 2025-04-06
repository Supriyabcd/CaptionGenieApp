import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'processing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 242, 230, 227),
      appBar: AppBar(title: const Text('Home'),backgroundColor:Color.fromARGB(255, 242, 230, 227)),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.image,color:  Color.fromARGB(255, 213, 72, 40)),
                label: const Text('Upload Image',style: TextStyle(color: Color.fromARGB(255, 213, 72, 40))),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 220, 198, 190)),
              ),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera,color: Color.fromARGB(255, 213, 72, 40)),
                label: const Text('Take Photo',style: TextStyle(color: Color.fromARGB(255, 213, 72, 40))),
                style: ElevatedButton.styleFrom(backgroundColor:  const Color.fromARGB(255, 220, 198, 190)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_image != null) Image.file(_image!, height: 200),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 213, 72, 40),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProcessingScreen()),
              );
            },
            child: const Text('Generate Caption',style: TextStyle(color: Color.fromARGB(255, 244, 242, 242))),
          ),
        ],
      ),
    );
  }
}
