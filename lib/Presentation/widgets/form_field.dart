// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../const/colors.dart';
import '../../const/size_radius.dart';

class CustomField extends HookWidget {
  final String title;
  final bool? visible;
  final bool? obscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomField({
    Key? key,
    required this.title,
    this.visible,
    this.obscure,
    this.controller,
    this.validator,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final passwordvisible = useState<bool>(obscure!);
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        width: size.width * 0.8,
        decoration: const BoxDecoration(
          color: textColor,
          borderRadius: radius10,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                obscureText:  passwordvisible.value,
                onEditingComplete: () {
                  // Clear the focus of the TextField when the keyboard is closed.
                  FocusNode();
                },
                validator: validator,
                controller: controller,
                decoration: InputDecoration(
                    hintText: title,
                    hintStyle: const TextStyle(color: hintColor, fontSize: 15),
                    border: InputBorder.none),
              ),
            ),
            Visibility(
                visible: visible!,
                child: IconButton(
                    onPressed: () {
                      passwordvisible.value = !passwordvisible.value;
                    },
                    icon: passwordvisible.value
                        ? Icon(
                            Icons.visibility,
                          )
                        : Icon(
                            Icons.visibility,
                            color: Colors.blue,
                          )))
          ],
        ));
  }
}