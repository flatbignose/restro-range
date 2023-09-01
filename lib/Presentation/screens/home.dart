import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/widgets/add_waiter.dart';
import 'package:restro_range/auth/controllers/auth_controller.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/lists.dart';
import 'package:restro_range/models/restaurant_model.dart';
import 'package:uuid/uuid.dart';

import '../../auth/screens/login.dart';
import '../../const/size_radius.dart';
import '../widgets/add_menu_item.dart';

class ScreenHome extends ConsumerStatefulWidget {
  static const routeName = '/home';
  const ScreenHome({super.key});

  @override
  ConsumerState<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends ConsumerState<ScreenHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _currentIndex = 0;

  changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: textColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: FutureBuilder<RestroModel?>(
                    future: ref.read(authContollerProvider).getUserData(),
                    builder: (context, snapshot) {
                      return Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage(
                                    'asset/images/restro_upload.jpg'),
                                fit: BoxFit.cover)),
                      );
                    }),
              ),
              Column(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == 4) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              elevation: 5,
                              backgroundColor: textColor,
                              content: const Text(
                                'Log Out Current Session?',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 150),
                                        width: size.width / 8,
                                        height: size.width / 8,
                                        decoration: BoxDecoration(
                                          color: primColor,
                                          borderRadius: radius10,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(4.0, 4.0),
                                              blurRadius: 6.0,
                                              spreadRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: TextButton(
                                            onPressed: () async {
                                              const CircularProgressIndicator();
                                              await FirebaseAuth.instance
                                                  .signOut();

                                              // ignore: use_build_context_synchronously
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  ScreenLogin.routeName,
                                                  (route) => false);
                                            },
                                            child: const Text(
                                              'Yes',
                                              style:
                                                  TextStyle(color: textColor),
                                            ))
                                        // IconButton(
                                        //     onPressed: () {},
                                        //     icon: const Icon(
                                        //       Icons.camera_alt_rounded,
                                        //       color: primColor,
                                        //     )),
                                        ),
                                    AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 150),
                                        width: size.width / 8,
                                        height: size.width / 8,
                                        decoration: BoxDecoration(
                                          color: primColor,
                                          borderRadius: radius10,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(4.0, 4.0),
                                              blurRadius: 6.0,
                                              spreadRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'No',
                                              style:
                                                  TextStyle(color: textColor),
                                            ))),
                                  ],
                                )
                              ],
                            );
                          },
                        );
                        // Future.delayed(const Duration(milliseconds: 2000));
                        // const CircularProgressIndicator();
                        // await FirebaseAuth.instance.signOut();
                        // ignore: use_build_context_synchronously
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, ScreenLogin.routeName, (route) => false);
                        // Navigator.popUntil(context,
                        //     ModalRoute.withName(ScreenLogin.routeName));
                      }
                    },
                    child: DrawerList(
                      icon: ConstantLists.drawerIconsList[index],
                      title: ConstantLists.drawerList[index],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      body: ConstantLists.screens[_currentIndex],
      extendBody: true,
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
          type: ExpandableFabType.up,
          backgroundColor: primColor,
          foregroundColor: backgroundColor,
          closeButtonStyle: const ExpandableFabCloseButtonStyle(
              backgroundColor: primColor, foregroundColor: backgroundColor),
          children: [
            FloatingActionButton.small(
                heroTag: null,
                child: const Icon(Icons.table_restaurant_rounded),
                onPressed: () async {
                  // addItems(1);
                  final uid = const Uuid().v1();
                  final tableData = await FirebaseFirestore.instance
                      .collection('restaurants')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('tables')
                      .get();
                  int tableNumber = tableData.docs.length + 1;
                  DateTime createDate = DateTime.now();
                  bool occupied = false;
                  Map<String, dynamic> data = {
                    'tableId': uid,
                    'createDate': createDate,
                    'occupied': occupied
                  };

                  await FirebaseFirestore.instance
                      .collection('restaurants')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('tables')
                      .doc(uid)
                      .set(data);
                }),
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.supervised_user_circle_outlined),
              onPressed: () {
                addItems(2);
              },
            ),
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.padding_rounded),
              onPressed: () {
                addItems(3);
              },
            )
          ]),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        child: BottomNavigationBar(
            backgroundColor: primColor,
            selectedItemColor: backgroundColor,
            unselectedItemColor: textColor,
            currentIndex: _currentIndex,
            onTap: (index) {
              changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.table_restaurant_rounded), label: 'Tables'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Waiters'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt), label: 'Menu'),
            ]),
      ),
    );
  }

  void addItems(int index) {
    showModalBottomSheet(
        backgroundColor: backgroundColor,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        elevation: 5,
        showDragHandle: true,
        builder: (context) {
          if (index == 1) {
            return const CircularProgressIndicator();
          } else if (index == 2) {
            return AddWaiter();
          } else {
            return const AddMenuItem();
          }
        });
  }
}

class DrawerList extends StatelessWidget {
  final IconData icon;
  final String title;
  const DrawerList({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(title),
          trailing: Icon(
            icon,
            color: primColor,
          ),
        ),
      ),
    );
  }
}
