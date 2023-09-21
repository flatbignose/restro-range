import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/menu/controller/menu_controller.dart';
import 'package:restro_range/Presentation/menu/screens/menu_item.dart';
import 'package:restro_range/const/colors.dart';

import '../../../const/size_radius.dart';
import '../widgets/category_card.dart';

class ScreenCategories extends ConsumerWidget {
  const ScreenCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double cellWidth = ((MediaQuery.of(context).size.width - size) / columnCount);
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: ref.read(menuControProvider).getMenuCategories(),
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
                      'Categories Loading...',
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
                    decoration: const BoxDecoration(
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
                const Text(
                  'Add Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: size.height * 0.29,
              crossAxisSpacing: 5,
              // childAspectRatio: size.height * 0.40 / size.width * 0.20,
            ),
            itemBuilder: (context, index) {
              final document = snapshot.data!.docs[index];
              final data = document.data() as Map<String, dynamic>;

              final name = data['categoryName'];
              final pic = data['categoryPic'];
              final categoryId = data['categoryId'];
              final restroId = data['restroId'];

              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenMenuItems(
                          context: context,
                          categoryName: name,
                          categoryId: categoryId,
                          restroId: restroId),
                    )),
                child: CategoryCard(
                  size: size,
                  categoryId: categoryId,
                  categoryName: name,
                  categoryPic: pic,
                  restroId: restroId,
                ),
              );
            },
            itemCount: snapshot.data!.docs.length,
          );
        });
  }
}
