import 'package:flutter/material.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
      ),
      home: const ScreenHome(),
    );
  }
}
