import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/waiters/controller/waiter_controller.dart';
import 'package:restro_range/Presentation/waiters/screens/waiter_profile.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/size_radius.dart';

class ScreenWaiter extends ConsumerStatefulWidget {
  static const routeName = '/waiters';
  const ScreenWaiter({super.key});

  @override
  ConsumerState<ScreenWaiter> createState() => _ScreenWaiterState();
}

final restroId = FirebaseAuth.instance.currentUser!.uid;

class _ScreenWaiterState extends ConsumerState<ScreenWaiter> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: ref.read(waiterControProvider).getWaiters(restroId),
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
            return const Text('No restaurants available.');
          }

          return Padding(
            padding: const EdgeInsets.all(13.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
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

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WaiterProfile(
                            waiterName: name,
                            waiterAge: age,
                            waiterPic: pic,
                            waiterId: waiterId,
                            waiterPhone: phone,
                            restroName: restroName,
                            restroId: restroId);
                      },
                    ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: radius10),
                    elevation: 5,
                    borderOnForeground: true,
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.loose,
                      children: [
                        SizedBox(
                          width: size.width,
                          height: size.height,
                          child: ClipRRect(
                              borderRadius: radius10,
                              child: CachedNetworkImage(
                                imageUrl: pic,
                                fit: BoxFit.cover,
                              )),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: hintColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              height: size.height * 0.05,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
