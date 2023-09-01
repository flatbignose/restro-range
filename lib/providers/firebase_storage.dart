import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonStorageProvider = Provider((ref) => CommonStorageRepo(
    firebaseStorage: FirebaseStorage.instance,
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance));

class CommonStorageRepo {
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  CommonStorageRepo(
      {required this.firebaseAuth,
      required this.firebaseStorage,
      required this.firestore});

  String? restroName;
  String? restroPic;
  String? restroAddress;
  String? restroOwner;
  String? restroPhone;
  String? restroEmail;

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getUserData() async {
    await firestore
        .collection('restaurants')
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          restroName = snapshot.data()!['restroName'];
          restroOwner = snapshot.data()!['owner'];
          restroAddress = snapshot.data()!['address'];
          restroPhone = snapshot.data()!['phoneNumber'];
          // restroPic = snapshot.data()![''];
          restroEmail = snapshot.data()![firebaseAuth.currentUser!.email];
        }
      },
    );
  }
}
