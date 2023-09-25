// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/menu/controller/menu_controller.dart';
import 'package:restro_range/Presentation/menu/widgets/add_food_item.dart';

import '../../../const/colors.dart';
import '../../../const/size_radius.dart';

class ScreenMenuItems extends ConsumerWidget {
  final String categoryName;
  final String categoryId;
  final String restroId;

  const ScreenMenuItems(
      {super.key,
      required BuildContext context,
      required this.categoryName,
      required this.categoryId,
      required this.restroId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add item'),
        icon: const Icon(Icons.add),
        onPressed: () {
          addFoodItem(context, categoryName, categoryId);
        },
      ),
      appBar: AppBar(
        title: Text('List of $categoryName'),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: ref
                  .read(menuControProvider)
                  .getMenuItems(categoryName: categoryName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                        height: size.height / 4.5,
                        width: size.height / 4.5,
                        decoration: const BoxDecoration(
                            borderRadius: radius10, color: backgroundColor),
                        child: const Center(
                          child: Text(
                            'Food Items Loading...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: radius10,
                          ),
                          width: 220,
                          height: 220,
                          child: Image.asset(
                            'asset/images/empty_waiters.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'No Items in $categoryName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
                    final data = document.data() as Map<String, dynamic>;

                    final foodName = data['foodName'];
                    final foodPic = data['foodPic'];
                    final categoryName = data['categoryId'];
                    final restroId = data['restroId'];

                    final foodPrice = data['foodPrice'];
                    final foodInfo = data['foodDescription'];
                    final categoryId = data['categoryId'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width * 0.95,
                        decoration: const BoxDecoration(
                          color: textColor,
                          borderRadius: radius10,
                        ),
                        child: ListTile(
                          leading: Container(
                            width: size.width * 0.12,
                            height: size.width * 0.12,
                            child: Image.network(
                              foodPic,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(foodName),
                          subtitle: Text(
                            foodInfo,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text('₹$foodPrice'),
                        ),
                      ),
                    );
                  },
                );
              })),
    );
  }

  addFoodItem(BuildContext context, String categoryName, String categoryId) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return AddFoodItem(
          categoryId: categoryId,
          categoryName: categoryName,
        );
      },
    );
  }
}
