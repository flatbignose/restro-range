import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/controllers.dart';
import 'package:restro_range/const/size_radius.dart';
import '../../Presentation/widgets/custom_button.dart';
import '../../Presentation/widgets/form_field.dart';
import '../../const/lists.dart';
import '../../const/utils.dart';
import '../controllers/auth_controller.dart';

class ScreenRegistration extends ConsumerWidget {
  static const routeName = '/registration';
  ScreenRegistration({super.key});

  final formkey = GlobalKey<FormState>();
  final emailExp = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  final passExp = RegExp(r'^[a-zA-Z0-9_!@#$%^&*()-+<>,.?/|~]{8,32}$');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerlist = ref.watch(regcontrolProvider);

    signUpUser() async {
      if (formkey.currentState!.validate()) {
        await ref.watch(authContollerProvider).signUpWithEmail(
              context: context,
              email: emailController.text,
              password: passwordController.text,
            );
        emailController.clear();
        passwordController.clear();
        confirmEmailController.clear();
        confirmPasswordController.clear();
      } else {
        showSnackbar(context: context, content: 'All should be filled');
      }
    }

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
            child: Image.asset(
              'asset/images/cover_1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Center(
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
                    Form(
                      key: formkey,
                      child: Column(
                        children: List.generate(4, (index) {
                          return CustomField(
                            size: size,
                            title: ConstantLists.regHintList[index],
                            obscure: index == 2 || index == 3 ? true : false,
                            visible: index == 2 || index == 3 ? true : false,
                            controller: controllerlist[index],
                            validator: (p0) {
                              if (index == 0) {
                                if (p0 == '' || p0 == null) {
                                  return 'Email is Required';
                                } else if (!emailExp.hasMatch(p0)) {
                                  return 'Enter valid email';
                                }
                                return null;
                              } else if (index == 1) {
                                if (p0 == '' || p0 == null) {
                                  return 'Email is Required';
                                } else if (p0 != emailController.text) {
                                  return 'email does not match';
                                }
                              } else if (index == 2) {
                                if (p0 == '') {
                                  return 'Password Required';
                                } else if (p0 == null) {
                                  return 'Enter Password';
                                }
                                return null;
                              } else if (index == 3) {
                                if (p0 != passwordController.text) {
                                  return 'passwords does not match';
                                }
                              }
                              return null;
                            },
                          );
                        }),
                      ),
                    ),
                    CustomButton(
                        size: size,
                        buttonColor: primColor,
                        title: 'Organize',
                        buttontextColor: backgroundColor,
                        onPressed: signUpUser),
                    height10,
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Wait, are you already a User?  ',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                            text: 'Login Here',
                            style: const TextStyle(
                                color: backgroundColor, fontSize: 18))
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
