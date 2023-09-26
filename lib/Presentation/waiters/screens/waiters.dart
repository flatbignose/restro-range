import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/waiters/controller/waiter_controller.dart';
import 'package:restro_range/Presentation/waiters/screens/edit_waiter_profile.dart';
import 'package:restro_range/Presentation/waiters/widgets/waiter_profile.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/loader.dart';
import 'package:restro_range/const/size_radius.dart';

class ScreenWaiter extends ConsumerStatefulWidget {
  static const routeName = '/waiters';
  const ScreenWaiter({super.key});

  @override
  ConsumerState<ScreenWaiter> createState() => _ScreenWaiterState();
}

final String restroId = FirebaseAuth.instance.currentUser!.uid;

class _ScreenWaiterState extends ConsumerState<ScreenWaiter> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: ref.read(waiterControProvider).getWaiters(),
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
                      'Waiters Loading...',
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
                  'Add Waiters',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ));
          }

          return Padding(
            padding: const EdgeInsets.all(13.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final document = snapshot.data!.docs[index];
                final data = document.data() as Map<String, dynamic>;
                

                final name = data['waiterName'];
                final pic = data['waiterPic'];
                final waiterId = data['userId'];
                final phone = data['waiterPhone'];
                final age = data['waiterAge'];
                final restroName = data['restroName'];
                final joinDate = data['joinDate'];

                return Stack(
                  children: [
                    WaiterCard(
                        joinDate: joinDate,
                        waiterName: name,
                        waiterAge: age,
                        waiterPic: pic,
                        waiterId: waiterId,
                        waiterPhone: phone,
                        restroId: restroId),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            optim(context, size, name, age, pic, waiterId,
                                phone, restroId, joinDate);
                          },
                          icon: Icon(Icons.more_vert_outlined)),
                    )
                  ],
                );
              },
            ),
          );
        });
  }

  Future<dynamic> optim(
    BuildContext context,
    Size size,
    String waiterName,
    String waiterAge,
    String waiterPic,
    String waiterId,
    String waiterPhone,
    String restroId,
    Timestamp joinDate,
  ) {
    return showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      showDragHandle: true,
      builder: (
        context,
      ) {
        return SizedBox(
          height: size.height / 6,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  await Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ScreenEditProfile(
                        waiterName: waiterName,
                        waiterAge: waiterAge,
                        waiterPic: waiterPic,
                        waiterId: waiterId,
                        waiterPhone: waiterPhone,
                        restroId: restroId,
                        joinDate: joinDate,
                      );
                    },
                  ));
                },
                child: const SizedBox(
                  child: ListTile(
                    title: Text(
                      'Edit',
                      style: TextStyle(color: backgroundColor),
                    ),
                    leading: Icon(Icons.edit),
                    iconColor: backgroundColor,
                  ),
                ),
              ),
              const Divider(
                thickness: 0.5,
                height: 0,
              ),
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  await options(context, waiterName, waiterId);
                },
                child: const ListTile(
                  title: Text(
                    'Delete',
                    style: TextStyle(color: backgroundColor),
                  ),
                  leading: Icon(Icons.delete),
                  iconColor: backgroundColor,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> options(BuildContext context, name, waiterId) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Remove $name From Waiters',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await FirebaseFirestore.instance
                      .collection('restaurants')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('waiters')
                      .doc(waiterId)
                      .delete();
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
