// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/menu_repo.dart';

final menuControProvider = Provider((ref) {
  final menuRepo = ref.watch(menuRepoProvider);
  return MenuController(ref: ref, menuRepo: menuRepo);
});

class MenuController {
  final MenuRepo menuRepo;
  final ProviderRef ref;
  MenuController({
    required this.menuRepo,
    required this.ref,
  });

  Future<void> addCategory({
    required BuildContext context,
    required File? categoryPic,
    required String categoryName,
  }) async {
    await menuRepo.addCategory(
      context: context,
      ref: ref,
      categoryPic: categoryPic,
      categoryName: categoryName,
    );
  }

  Future<void> saveMenuItemtoFirebase({
    required BuildContext context,
    required File? foodPic,
    required String foodPrice,
    required String foodName,
    required String foodInfo,
    required String categoryName,
    required String categoryId,
  }) {
  return  menuRepo.addMenuItem(
      context: context,
      ref: ref,
      foodPic: foodPic,
      foodPrice: foodPrice,
      foodName: foodName,
      foodInfo: foodInfo,
      categoryName: categoryName,
      categoryId: categoryId,
    );
  }

  Stream<QuerySnapshot<Object>> getMenuCategories() {
    return menuRepo.getCategories();
  }

  Stream<QuerySnapshot<Object>> getMenuItems({required String categoryName}) {
    return menuRepo.getMenuItems(categoryName: categoryName);
  }
  Stream<QuerySnapshot>getOrders(){
    return menuRepo.orderNotifications(); 
  }
}
