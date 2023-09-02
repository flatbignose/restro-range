// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final tableRepoProvider = Provider((ref) => TableRepo(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class TableRepo {
  final FirebaseFirestore firestore;
  // final FirebaseStorage storage;
  final FirebaseAuth auth;
  TableRepo({
    required this.firestore,
    required this.auth,
  });

  Future<void> addTableToFirebase() async {
    final uid = const Uuid().v1();

    DateTime createDate = DateTime.now();
    bool occupied = false;
    Map<String, dynamic> data = {
      'tableId': uid,
      'createDate': createDate,
      'occupied': occupied
    };

    await firestore
        .collection('restaurants')
        .doc(auth.currentUser!.uid)
        .collection('tables')
        .doc(uid)
        .set(data);
  }

  Future<void> updateTableFirebase(Map<String, dynamic> data) async {
    bool occupied = !data['occupied'];
    Map<String, dynamic> datas = {
      'tableId': data['tableId'],
      'createDate': data['createDate'],
      'occupied': occupied
    };
    await firestore
        .collection('restaurants')
        .doc(auth.currentUser!.uid)
        .collection('tables')
        .doc(data['tableId'])
        .set(datas);
  }

  Future<dynamic> delete(BuildContext context, int index, tableId) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Remove Table ${index + 1}?',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  const CircularProgressIndicator(       
                    backgroundColor: Colors.red,
                    strokeWidth: 20,
                  );
                  await firestore
                      .collection('restaurants')
                      .doc(auth.currentUser!.uid)
                      .collection('tables')
                      .doc(tableId)
                      .delete();
                  Navigator.pop(context);
                },
                child: const Text('Confirm')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'))
          ],
        );
      },
    );
  }
}
