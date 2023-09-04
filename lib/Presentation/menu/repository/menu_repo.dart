// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/widgets/add_menu_item.dart';
import 'package:uuid/uuid.dart';

import '../../../const/utils.dart';
import '../../../providers/firebase_storage.dart';

final menuRepoProvider = Provider((ref) => MenuRepo(
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
    auth: FirebaseAuth.instance));

class MenuRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  MenuRepo({
    required this.auth,
    required this.firestore,
    required this.storage,
  });
  Future<void> addCategory({
    required BuildContext context,
    required ProviderRef ref,
    required File? categoryPic,
    required String categoryName,
  }) async {
    try {
      String restroId = auth.currentUser!.uid;
      String photoUrl =
          'https://images.unsplash.com/photo-1555244162-803834f70033?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjBmb29kfGVufDB8fDB8fHww&w=1000&q=80';
      final uid = const Uuid().v1();

      DateTime createDate = DateTime.now();
      if (categoryPic != null) {
        photoUrl = await ref
            .read(commonStorageProvider)
            .storeFileToFirebase('categoryPic/$uid', categoryPic);
      }
      Map<String, dynamic> category = {
        'categoryName': categoryName,
        'createDate': createDate,
        'categoryId': uid,
        'restroId': restroId,
        'categoryPic': photoUrl,
      };
      await firestore
          .collection('restaurants')
          .doc(restroId)
          .collection('menuCategory')
          .doc(uid)
          .set(category);
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  //half baked add data
  Future<void> addMenuItem({
    required BuildContext context,
    required ProviderRef ref,
    required File? foodPic,
    required String foodPrice,
    required String foodName,
    required String foodInfo,
    required String categoryName,
    required String categoryId,
  }) async {
    try {
      String restroId = auth.currentUser!.uid;
      String photoUrl =
          'https://images.unsplash.com/photo-1555244162-803834f70033?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjBmb29kfGVufDB8fDB8fHww&w=1000&q=80';
      final uid = const Uuid().v1();

      DateTime createDate = DateTime.now();
      if (foodPic != null) {
        photoUrl = await ref
            .read(commonStorageProvider)
            .storeFileToFirebase('categoryPic/foodpic/$uid', foodPic);
      }
      Map<String, dynamic> foodItem = {
        'foodName': foodName,
        'categoryName': categoryName,
        'createDate': createDate,
        'categoryId': categoryId,
        'restroId': restroId,
        'foodPic': photoUrl,
        'foodDescription': foodInfo,
        'foodPrice': foodPrice,
      };
      await firestore
          .collection('restaurants')
          .doc(restroId)
          .collection('menuCategory')
          .doc(categoryId)
          .collection('foodItems')
          .doc(uid)
          .set(foodItem);
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  Stream<QuerySnapshot<Object>> getCategories() {
    return firestore
        .collection('restaurants')
        .doc(auth.currentUser!.uid)
        .collection('menuCategory')
        .orderBy('createDate')
        .snapshots();
  }

//half baked data
  Stream<QuerySnapshot<Object>> getMenuItems({required String categoryId}) {
    return firestore
        .collection('restaurants')
        .doc(auth.currentUser!.uid)
        .collection('menuCategory')
        .doc(categoryId)
        .collection('foodItems')
        .orderBy('createDate')
        .snapshots();
  }
}
