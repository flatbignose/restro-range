import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/tables/controller/table_controller.dart';
import 'package:restro_range/Presentation/waiters/controller/waiter_controller.dart';

class ScreenTables extends ConsumerWidget {
  static const routeName = '/tables';
  const ScreenTables({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: ref.read(waiterControProvider).getTables(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              itemCount: snapshots.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1, mainAxisSpacing: 20),
              itemBuilder: (context, index) {
                final document = snapshots.data!.docs[index];
                final data = document.data() as Map<String, dynamic>;
                final tableId = data['tableId'];
                return GestureDetector(
                  onLongPress: () async {
                    HapticFeedback.vibrate();
                    ref
                        .read(tableControlProvider)
                        .deleteTable(context, index, tableId);
                  },
                  onTap: () async {
                    //
                    ref.read(tableControlProvider).updateTable(data);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      data['occupied'] == false
                          ? Image.asset('asset/images/table_4_unoccupied.png')
                          : Image.asset('asset/images/table_4_occupied.png'),
                      Text('Table ${index + 1}')
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}

          // 'asset/images/table_4_unoccupied.png',