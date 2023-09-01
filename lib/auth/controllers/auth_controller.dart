// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/auth/repository/auth_repository.dart';
import 'package:restro_range/models/restaurant_model.dart';

final authContollerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthContoller(authRepo: authRepo, ref: ref);
});

final userDataProvider = FutureProvider((ref) {
  final authController = ref.watch(authContollerProvider);
  return authController.getUserData();
});

class AuthContoller {
  final AuthRepo authRepo;
  final ProviderRef ref;
  AuthContoller({
    required this.authRepo,
    required this.ref,
  });

  Future<RestroModel?> getUserData() async {
    RestroModel? restaurant = await authRepo.getCurrentUserData();
    return restaurant;
  }

  Future<void> signUpWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    await authRepo.signUpWithEmailRepo(
        context: context, email: email, password: password);
  }

  Future<void> loginEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    await authRepo.loginWithEmailRepo(
        context: context, email: email, password: password);
  }

  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    await authRepo.resetPassword(email: email, context: context);
  }

  Future<void> saveRestroInfo({
    required BuildContext context,
    required String restroName,
    required String owner,
    required String address,
    required String phoneNumber,
    required File? restroPic,
  }) async {
    await authRepo.saveRestroInfoRepo(
        context: context,
        ref: ref,
        restroName: restroName,
        owner: owner,
        address: address,
        phoneNumber: phoneNumber,
        restroPic: restroPic);
  }
}
