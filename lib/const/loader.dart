import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restro_range/const/colors.dart';


class ScreenLoader extends StatelessWidget {
  const ScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/images/cover_1.jpg'),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'RestroRange',
              style: TextStyle(color: primColor, fontSize: 70),
            ),
            Positioned(
              bottom: 180,
              child: Lottie.asset(
                  'assets/lottie_files/bright-loading-dots.json',
                  repeat: true,
                  fit: BoxFit.cover,
                  height: 50),
            ),
          ],
        ),
      ),
    );
  }
}
