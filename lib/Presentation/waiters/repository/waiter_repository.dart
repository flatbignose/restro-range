// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/const/utils.dart';
import 'package:restro_range/models/waiter_model.dart';
import 'package:restro_range/providers/firebase_storage.dart';

final waiterRepoProvider = Provider((ref) => WaiterRepo(
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
    auth: FirebaseAuth.instance));

class WaiterRepo {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final FirebaseAuth auth;
  WaiterRepo(
      {required this.firestore, required this.storage, required this.auth});

  Future<void> addWaiter({
    required BuildContext context,
    required ProviderRef ref,
    required File? waiterPic,
    required String waiterName,
    required String waiterAge,
    required String waiterPhone,
    required String userId,
    required String restroName,
  }) async {
    try {
      String restroId = auth.currentUser!.uid;
      String photoUrl =
          'https://firebasestorage.googleapis.com/v0/b/restro-range.appspot.com/o/waiter.png?alt=media&token=47a1ec0c-5f8c-484a-b640-e32f92d16319';

      if (waiterPic != null) {
        photoUrl = await ref
            .read(commonStorageProvider)
            .storeFileToFirebase('waiterdp/$userId', waiterPic);
      }
      final waiter = WaiterModel(
          joinDate: DateTime.now(),
          waiterPic: photoUrl,
          waiterName: waiterName,
          waiterAge: waiterAge,
          waiterPhone: waiterPhone,
          restroName: restroName,
          userId: userId,
          restroId: restroId);
      await firestore
          .collection('restaurants')
          .doc(restroId)
          .collection('waiters')
          .doc(userId)
          .set(waiter.toMap());
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  Stream<QuerySnapshot<Object>> getWaiters() {
    return firestore
        .collection('restaurants')
        .doc(auth.currentUser!.uid)
        .collection('waiters')
        .orderBy('joinDate')
        .snapshots();
  }

  Stream<QuerySnapshot<Object>> getTables() {
    return firestore
        .collection('restaurants')
        .doc(auth.currentUser!.uid)
        .collection('tables')
        .orderBy('createDate')
        .snapshots();
  }
}
