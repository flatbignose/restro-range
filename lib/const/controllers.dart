import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final textControllerProvider = StateProvider<TextEditingController>((ref) {
//   return TextEditingController();
// });

final listOfControllersProvider = Provider<List<TextEditingController>>((ref) {
  return [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
});

TextEditingController emailController = TextEditingController();
TextEditingController confirmEmailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
final regcontrolProvider = Provider<List<TextEditingController>>((ref) {
  return [
    emailController,
    confirmEmailController,
    passwordController,
    confirmPasswordController
  ];
});

TextEditingController nameController = TextEditingController();
TextEditingController ownerController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController ageController = TextEditingController();
TextEditingController restroController = TextEditingController();
TextEditingController idController = TextEditingController();

final resDetailsControlProvider = Provider<List<TextEditingController>>((ref) {
  return [
    nameController,
    ownerController,
    addressController,
    phoneController,
  ];
});


