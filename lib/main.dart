import 'package:flutter/material.dart';
import 'main_navigation.dart';

void main() {
  runApp(const WarunkMeksApp());
}

class WarunkMeksApp extends StatelessWidget {
  const WarunkMeksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WarunkMeks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        // Warna background gelap kebiruan kustom dari Figma kamu
        scaffoldBackgroundColor: const Color(0xFF131422), 
        primaryColor: const Color(0xFF2E54EA), // Warna biru tombol utama
      ),
      home: const MainNavigation(),
    );
  }
}