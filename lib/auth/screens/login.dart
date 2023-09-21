import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/auth/controllers/auth_controller.dart';
import 'package:restro_range/auth/screens/registration.dart';
import 'package:restro_range/auth/widgets/reset_password.dart';
import 'package:restro_range/const/loader.dart';
import 'package:restro_range/const/utils.dart';
import '../../Presentation/widgets/custom_button.dart';
import '../../Presentation/widgets/form_field.dart';
import '../../const/colors.dart';
import '../../const/size_radius.dart';

class ScreenLogin extends ConsumerWidget {
  static const routeName = '/login';
  ScreenLogin({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final emailExp = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  final passExp = RegExp(r'^[a-zA-Z0-9_!@#$%^&*()-+<>,.?/|~]{8,32}$');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loginUser() {
      if (formkey.currentState!.validate()) {
        showDialog(
          context: context,
          builder: (context) => const Loader(title: 'Logging In'),
        );
        ref.watch(authContollerProvider).loginEmail(
              context: context,
              email: emailController.text,
              password: passwordController.text,
            );

      } else {
        showSnackbar(context: context, content: 'Fill All Fields');
      }
    }

    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage('asset/images/cover_2.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.darken)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
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
            Form(
              key: formkey,
              child: Column(
                children: [
                  CustomField(
                    // ontap: () {
                    //   return formkey.currentState!.reset();
                    // },
                    visible: false,
                    obscure: false,
                    size: size,
                    title: 'Enter Registered Email',
                    controller: emailController,
                    validator: (p0) {
                      if (p0 == '') {
                        return 'Email is Required';
                      } else if (p0 == null) {
                        return 'Email is Required';
                      } else if (!emailExp.hasMatch(p0)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  CustomField(
                    // ontap: () {
                    //   return formkey.currentState!.reset();
                    // },
                    visible: true,
                    obscure: true,
                    size: size,
                    title: 'Enter Your Password',
                    controller: passwordController,
                    validator: (p0) {
                      if (p0 == '') {
                        return 'Password Required';
                      } else if (p0 == null) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            CustomButton(
              size: size,
              buttonColor: backgroundColor,
              title: 'Login',
              buttontextColor: primColor,
              onPressed: loginUser,
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
                              builder: (context) => ScreenRegistration(),
                            ));
                      },
                    text: 'Sign Up Here',
                    style:
                        const TextStyle(color: backgroundColor, fontSize: 18))
              ]),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    resetPassword(context);
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        decoration: TextDecoration.underline),
                  )),
            )
          ],
        ),
      ),
    );
  }

  resetPassword(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const ResetPassword(),
        );
      },
    );
  }
}
