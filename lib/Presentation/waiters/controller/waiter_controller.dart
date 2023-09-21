// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restro_range/Presentation/waiters/repository/waiter_repository.dart';

final waiterControProvider = Provider((ref) {
  final waiterRepo = ref.watch(waiterRepoProvider);
  return WaiterController(ref: ref, waiterRepo: waiterRepo);
});

class WaiterController {
  final WaiterRepo waiterRepo;
  final ProviderRef ref;
  WaiterController({
    required this.waiterRepo,
    required this.ref,
  });

  Future<void> savewaiterInfo({
    required BuildContext context,
    required File? waiterPic,
    required String waiterName,
    required String waiterAge,
    required String waiterPhone,
    required String userId,
  }) async {
    await waiterRepo.addWaiter(
      context: context,
      ref: ref,
      waiterPic: waiterPic,
      waiterName: waiterName,
      waiterAge: waiterAge,
      waiterPhone: waiterPhone,
      userId: userId,
    );
  }

  Stream<QuerySnapshot<Object>> getWaiters() {
    return waiterRepo.getWaiters();
  }

  Stream<QuerySnapshot<Object>> getTables() {
    return waiterRepo.getTables();
  }
}
