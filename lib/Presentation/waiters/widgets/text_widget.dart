import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.titlevalue, required this.title});

  final String title;
  final String titlevalue;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title :  $titlevalue',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
