import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restro_range/auth/controllers/auth_controller.dart';
import 'package:restro_range/const/controllers.dart';
import 'package:restro_range/const/size_radius.dart';

import '../../Presentation/widgets/custom_button.dart';
import '../../Presentation/widgets/form_field.dart';
import '../../const/colors.dart';

class ResetPassword extends ConsumerWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String assetName = 'asset/images/reset_password.svg';
    void resetPassword() async {
      await ref
          .read(authContollerProvider)
          .resetPassword(email: emailController.text, context: context);
      emailController.clear();
    }

    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            height20,
            SizedBox(
                width: size.width / 2,
                height: size.height / 4,
                child: SvgPicture.asset(assetName)),
            CustomField(
              obscure: false,
              visible: false,
              title: 'Enter your email address',
              size: size,
              controller: emailController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: CustomButton(
                size: size,
                buttonColor: primColor,
                title: 'Confirm',
                buttontextColor: backgroundColor,
                onPressed: resetPassword,
              ),
            ),
            height20,
          ],
        ),
      ),
    );
  }
}
