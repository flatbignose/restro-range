import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/auth/controllers/auth_controller.dart';

import '../../auth/screens/login.dart';
import '../../const/colors.dart';
import '../../const/size_radius.dart';

class LogOutPop extends ConsumerWidget {
  const LogOutPop({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return AlertDialog(
      elevation: 5,
      backgroundColor: textColor,
      content: const Text(
        'Log Out Current Session?',
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
                duration:
                    const Duration(milliseconds: 150),
                width: size.width / 8,
                height: size.width / 8,
                decoration: BoxDecoration(
                  color: primColor,
                  borderRadius: radius10,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: TextButton(
                    onPressed: () async {
                      const CircularProgressIndicator();
                      await ref.read(authContollerProvider).logOut();

                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          ScreenLogin.routeName,
                          (route) => false);
                    },
                    child: const Text(
                      'Yes',
                      style:
                          TextStyle(color: textColor),
                    ))
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.camera_alt_rounded,
                //       color: primColor,
                //     )),
                ),
            AnimatedContainer(
                duration:
                    const Duration(milliseconds: 150),
                width: size.width / 8,
                height: size.width / 8,
                decoration: BoxDecoration(
                  color: primColor,
                  borderRadius: radius10,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'No',
                      style:
                          TextStyle(color: textColor),
                    ))),
          ],
        )
      ],
    );
  }
}

