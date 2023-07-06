import 'package:flutter/material.dart';
import 'package:restro_range/auth/screens/login.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/size_radius.dart';
import 'package:restro_range/auth/screens/registration.dart';

class ScreenLaunch extends StatelessWidget {
  const ScreenLaunch({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage('asset/images/getting_started.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Supercharge your restaurant's success with our app: unleash speed, efficiency, and flawless organization for dining perfection!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, fontSize: 30),
                  ),
                  SizedBox(
                    width: size.width / 2,
                    height: size.height * 0.08,
                    child: MaterialButton(
                        color: primColor,
                        shape: const ContinuousRectangleBorder(
                            borderRadius: radius20),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                              begin: const Offset(0, 0.5),
                                              end: const Offset(0, 0))
                                          .animate(animation),
                                      child: const ScreenLogin(),
                                    );
                                  }));
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
