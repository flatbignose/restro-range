import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/menu/orders.dart';
import 'package:restro_range/Presentation/menu/repository/menu_repo.dart';
import 'package:restro_range/Presentation/tables/controller/table_controller.dart';
import 'package:restro_range/Presentation/waiters/controller/waiter_controller.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/utils.dart';

import '../../../const/size_radius.dart';

class ScreenTables extends ConsumerWidget {
  static const routeName = '/tables';
  const ScreenTables({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: ref.watch(waiterControProvider).getTables(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              itemCount: snapshots.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final document = snapshots.data!.docs[index];
                final data = document.data() as Map<String, dynamic>;
                final tableId = data['tableId'];
                final bool occupied = data['occupied'];
                return GestureDetector(
                  onLongPress: () async {
                    HapticFeedback.vibrate();
                    ref
                        .read(tableControlProvider)
                        .deleteTable(context, index, tableId);
                  },
                  onTap: () async {
                    // if (occupied == true) {
                    //   Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) {
                    //       return Orders(tableId: tableId,index: index,);
                    //     },
                    //   ));
                    // } else {
                    // }
                    // options(context, size, occupied, ref, data);
                    if (occupied == true) {
                      await ref.read(menuRepoProvider).callOrder(tableId);
                      // ignore: use_build_context_synchronously
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return BillGeneration(
                            tableIndex: index,
                            tableId: tableId,
                          );
                        },
                      ));
                    } else {
                      showSnackbar(
                          context: context, content: 'Table Not Occupied!');
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      data['occupied'] == false
                          ? Image.asset('asset/images/table_2_unoccupied.png')
                          : Image.asset('asset/images/table_2_occupied.png'),
                      Positioned(
                        bottom: 22,
                        child: Text(
                          'Table ${index + 1}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              background: Paint()
                                ..strokeWidth = 30.0
                                ..color = Colors.white
                                ..style = PaintingStyle.stroke
                                ..strokeJoin = StrokeJoin.round),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  Future<dynamic> options(BuildContext context, Size size, bool occupied,
      WidgetRef ref, Map<String, dynamic> data) {
    return showModalBottomSheet(
      backgroundColor: backgroundColor,
      showDragHandle: true,
      // barrierColor: backgroundColor,
      context: context,
      builder: (context) {
        return SizedBox(
          width: size.width,
          height: size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              occupied == false
                  ? const Text(
                      'Mark Table Occupied?',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const Text(
                      'Mark Table Vacant?',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        ref.watch(tableControlProvider).updateTable(data);
                        Navigator.pop(context);
                      },
                      child: Container(
                          // height: size.height * 0.07,
                          width: size.width / 3,
                          decoration: const BoxDecoration(
                            borderRadius: radius20,
                            color: primColor,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            'Confirm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                            ),
                          ))),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          // height: size.height * 0.07,
                          width: size.width / 3,
                          decoration: const BoxDecoration(
                            borderRadius: radius20,
                            color: primColor,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                            ),
                          ))),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

// 'asset/images/table_4_unoccupied.png',
