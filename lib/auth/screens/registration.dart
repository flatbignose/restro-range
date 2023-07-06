import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/size_radius.dart';
import 'package:restro_range/screens/restro_details.dart';
import 'package:restro_range/widgets/form_field.dart';

import '../../const/lists.dart';
import '../../widgets/custom_button.dart';

class ScreenRegistration extends StatelessWidget {
  const ScreenRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('asset/images/cover_1.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '"Organize The Chaos"',
              style: TextStyle(
                color: textColor,
                fontSize: 30,
              ),
            ),
            height20,
            Column(
              children: List.generate(4, (index) {
                return CustomField(size: size, title: RegHintList[index]);
              }),
            ),
            CustomButton(
              size: size,
              buttonColor: primColor,
              title: 'Organize',
              buttontextColor: backgroundColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenRestroDetails(),
                    ));
              },
            ),
            height10,
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Wait, You are already a User?  ',
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
                    text: 'Login Here',
                    style: TextStyle(color: backgroundColor, fontSize: 18))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
