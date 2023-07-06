import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restro_range/auth/screens/registration.dart';
import 'package:restro_range/screens/home.dart';
import '../../const/colors.dart';
import '../../const/size_radius.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/form_field.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('asset/images/cover_2.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.darken)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                color: textColor,
                fontSize: 30,
              ),
            ),
            height20,
            Column(
              children: [
                CustomField(size: size, title: 'Enter Registered Email'),
                CustomField(size: size, title: 'Enter Your Password'),
              ],
            ),
            CustomButton(
              size: size,
              buttonColor: backgroundColor,
              title: 'Login',
              buttontextColor: primColor,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenHome(),
                    ),
                    (route) => false);
              },
            ),
            height10,
            RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: "Don't Have an account? ",
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScreenRegistration(),
                            ));
                      },
                    text: 'Sign Up Here',
                    style: const TextStyle(color: backgroundColor, fontSize: 18))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
