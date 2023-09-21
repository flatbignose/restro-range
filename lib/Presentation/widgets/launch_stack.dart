import 'package:flutter/material.dart';
import 'package:restro_range/Presentation/widgets/custom_button.dart';
import 'package:restro_range/const/loader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../auth/screens/login.dart';
import '../../const/colors.dart';
import '../../const/size_radius.dart';

class LaunchPages extends StatelessWidget {
  final String description;
  final bool isButton;
  final bool isSkip;
  const LaunchPages({
    super.key,
    required this.size,
    required this.description,
    required this.isButton,
    required this.isSkip,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              description,
              style: const TextStyle(color: textColor, fontSize: 25),
            ),
            height20,
            Visibility(
              visible: isButton,
              child: Positioned(
                bottom: size.height / 11,
                child: SizedBox(
                  width: size.width / 2,
                  height: size.height * 0.08,
                  child: MaterialButton(
                      color: primColor,
                      shape: const ContinuousRectangleBorder(
                          borderRadius: radius20),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Loader(title: 'Dining in...',);
                          },
                        );
                        Future.delayed(Duration(seconds: 3)).then((value) {
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, ScreenLogin.routeName, (route) => false);
                        });
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                            color: backgroundColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            Visibility(
              visible: isSkip,
              child: Positioned(
                top: 0,
                right: 0,
                child: TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Loader(
                          title: 'Dining in...',
                        );
                      },
                    );
                    Future.delayed(Duration(seconds: 1)).then((value) {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, ScreenLogin.routeName, (route) => false);
                    });
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
