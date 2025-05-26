import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'caption_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  bool _isLoading = false;
  final String apiUrl = 'http://<yourIPaddress>/generate_caption'; // Replace with your IPv4 address .

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _generateCaption() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
      var response = await request.send();

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        String caption = jsonResponse['caption'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CaptionScreen(caption: caption),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 230, 227),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(255, 242, 230, 227),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.image, color: Color.fromARGB(255, 213, 72, 40)),
                label: const Text('Upload Image', style: TextStyle(color: Color.fromARGB(255, 213, 72, 40))),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 220, 198, 190)),
              ),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera, color: Color.fromARGB(255, 213, 72, 40)),
                label: const Text('Take Photo', style: TextStyle(color: Color.fromARGB(255, 213, 72, 40))),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 220, 198, 190)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_image != null) Image.file(_image!, height: 200),
          const SizedBox(height: 20),
          _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 213, 72, 40),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _generateCaption,
                  child: const Text(
                    'Generate Caption',
                    style: TextStyle(color: Color.fromARGB(255, 244, 242, 242)),
                  ),
                ),
        ],
      ),
    );
  }
}
