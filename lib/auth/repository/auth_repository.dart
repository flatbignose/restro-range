import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/screens/home.dart';
import 'package:restro_range/auth/screens/restro_details.dart';
import 'package:restro_range/const/loader.dart';
import 'package:restro_range/const/utils.dart';
import 'package:restro_range/models/restaurant_model.dart';
import 'package:restro_range/providers/firebase_storage.dart';

import '../../const/controllers.dart';

final authRepoProvider = Provider((ref) => AuthRepo(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class AuthRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepo({
    required this.auth,
    required this.firestore,
  });

  Future<RestroModel?> getCurrentUserData() async {
    var userData = await firestore
        .collection('restaurants')
        .doc(auth.currentUser?.uid)
        .get();

    RestroModel? restaurant;
    if (userData.data() != null) {
      restaurant = RestroModel.fromMap(userData.data()!);
    }

    return restaurant;
  }

  Future<void> signUpWithEmailRepo({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emailController.clear();
      passwordController.clear();
      confirmEmailController.clear();
      confirmPasswordController.clear();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(ScreenRestroDetails.routeName);
    } on FirebaseAuthException catch (e) {
      showSnackbar(context: context, content: e.message!);
      Navigator.pop(context);
    }
  }

  Future<void> loginWithEmailRepo({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emailController.clear();
      passwordController.clear();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(ScreenHome.routeName);
    } on FirebaseAuthException catch (e) {
      showSnackbar(context: context, content: e.message!);
      Navigator.pop(context);
    }
  }

  Future<void> resetPassword(
      {required BuildContext context, required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      showSnackbar(
          context: context, content: 'Password change request have been sent');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  Future<void> saveRestroInfoRepo({
    required BuildContext context,
    required ProviderRef ref,
    required String restroName,
    required String owner,
    required String address,
    required String phoneNumber,
    required File? restroPic,
  }) async {
    try {
      String restroId = auth.currentUser!.uid;
      String photoUrl = 'asset/images/restro_upload.jpg';
      if (restroPic != null) {
        photoUrl = await ref
            .read(commonStorageProvider)
            .storeFileToFirebase('restroPic/$restroId', restroPic);
      }
      final restaurant = RestroModel(
          restroName: restroName,
          owner: owner,
          address: address,
          phoneNumber: phoneNumber,
          restroEmail: auth.currentUser!.email!,
          restroPic: photoUrl,
          restroId: restroId);

      await firestore
          .collection('restaurants')
          .doc(restroId)
          .set(restaurant.toMap());

      nameController.clear();
      ownerController.clear();
      addressController.clear();
      phoneController.clear();
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
      Navigator.pop(context);
    }
  }

  signOut() async {
    await auth.signOut();
  }
}
