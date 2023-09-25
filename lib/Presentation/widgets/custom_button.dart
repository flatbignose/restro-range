import 'package:flutter/material.dart';

import '../../const/size_radius.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final Color buttontextColor;
  final String title;
  final Function() onPressed;

  const CustomButton({
    super.key,
    required this.size,
    required this.buttonColor,
    required this.title,
    required this.buttontextColor,
    required this.onPressed,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width / 3,
      height: size.height / 16,
      child: MaterialButton(
          color: buttonColor,
          shape: const ContinuousRectangleBorder(borderRadius: radius20),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              color: buttontextColor,
              fontSize: 18,
            ),
          )),
    );
  }
}
