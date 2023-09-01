import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenTables extends StatelessWidget {
  static const routeName = '/tables';
  const ScreenTables({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('restaurants')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('tables')
              .orderBy('createDate')
              .snapshots(),
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
                return GestureDetector(
                  onLongPress: () async {
                    HapticFeedback.vibrate();
                    await FirebaseFirestore.instance
                        .collection('restaurants')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('tables')
                        .doc(data['tableId'])
                        .delete();
                  },
                  onTap: () async {
                    //
                    bool occupied = !data['occupied'];
                    Map<String, dynamic> datas = {
                      'tableId': data['tableId'],
                      'createDate': data['createDate'],
                      'occupied': occupied
                    };
                    await FirebaseFirestore.instance
                        .collection('restaurants')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('tables')
                        .doc(data['tableId'])
                        .set(datas);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      data['occupied'] == false
                          ? Image.asset('asset/images/table_4_unoccupied.png')
                          : Image.asset('asset/images/table_4_occupied.png'),
                      data['occupied'] == false
                          ? Text('Table ${index + 1}')
                          : Text(
                              'Table ${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            )
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