import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restro_range/const/colors.dart';

class Loader extends StatelessWidget {
  final String title;
  const Loader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset(
              'asset/lottie_files/orange.json',
              repeat: true,
              fit: BoxFit.cover,
              height: 250,
            ),
            Positioned(
              bottom: 50,
              child: Text(
                title,
                style: TextStyle(fontSize: 20, color: textColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
