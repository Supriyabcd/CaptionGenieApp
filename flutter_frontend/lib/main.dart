import 'package:flutter/material.dart';
import 'caption_genie_screen.dart';

void main() {
  runApp(const CaptionGenieApp());
}

class CaptionGenieApp extends StatefulWidget {
  const CaptionGenieApp({super.key});

  @override
  State<CaptionGenieApp> createState() => MyAppState();
}

class MyAppState extends State<CaptionGenieApp> {
  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();

  ThemeMode _themeMode = ThemeMode.light;

  void changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: const CaptionGenieScreen(),
    );
  }
}
