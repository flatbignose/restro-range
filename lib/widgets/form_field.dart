import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../const/size_radius.dart';

class CustomField extends StatelessWidget {
  final String title;
  const CustomField({
    super.key,
    required this.size,
    required this.title,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: radius10,
        ),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: title,
              hintStyle: TextStyle(color: hintColor, fontSize: 15),
              border: InputBorder.none),
        ));
  }
}
