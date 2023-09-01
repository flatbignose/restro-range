import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/size_radius.dart';

void showSnackbar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: TextStyle(color: primColor),
    ),
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    backgroundColor: backgroundColor,
    shape: ContinuousRectangleBorder(borderRadius: radius20),
    animation: CurvedAnimation(
        parent: kAlwaysCompleteAnimation, curve: Curves.easeInOut),
    duration: Duration(milliseconds: 1500),
  ));
}

String imagePath = '';
Future<File?> pickImageFromGallery(
    BuildContext context, ImageSource source) async {
  File? image;
  try {
    final pickImage = await ImagePicker().pickImage(source: source);
    if (pickImage != null) {
      image = File(pickImage.path);
    }
  } catch (e) {
    showSnackbar(context: context, content: e.toString());
  }
  return image;
}
