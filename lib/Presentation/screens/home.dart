import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restro_range/Presentation/menu/screens/orders.dart';
import 'package:restro_range/Presentation/tables/controller/table_controller.dart';
import 'package:restro_range/Presentation/waiters/screens/waiters.dart';
import 'package:restro_range/Presentation/widgets/add_waiter.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/lists.dart';
import 'package:restro_range/const/size_radius.dart';
import '../widgets/Drawer.dart';
import '../widgets/add_menu_item.dart';

class ScreenHome extends ConsumerStatefulWidget {
  static const routeName = '/home';
  const ScreenHome({super.key});

  @override
  ConsumerState<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends ConsumerState<ScreenHome> {
  int _currentIndex = 0;
  IconData _currentIcon = Icons.table_bar_rounded;

  changeIndex(int index) {
    setState(() {
      _currentIndex = index;
      _currentIcon = index == 0
          ? Icons.table_bar_rounded
          : _currentIcon = index == 1
              ? Icons.supervised_user_circle_outlined
              : Icons.menu_book_rounded;
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return OrderList();
                  },
                ));
              },
              icon: const Icon(Icons.fastfood_outlined))
        ],
      ),
      drawer: SafeArea(
        child: RestroDrawer(ref: ref, size: size),
      ),
      body: ConstantLists.screens[_currentIndex],
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        key: ValueKey<int>(_currentIndex),
        backgroundColor: primColor,
        foregroundColor: backgroundColor,
        onPressed: () {
          if (_currentIndex == 0) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add New Table?'),
                  actions: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              ref
                                  .watch(tableControlProvider)
                                  .addTable(context: context);
                              Navigator.pop(context);
                            },
                            child: const Text('Add Table')),
                        height10,
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                      ],
                    )
                  ],
                );
              },
            );
          } else if (_currentIndex == 1) {
            addItems(2, context);
          } else {
            addItems(3, context);
          }
        },
        child: Icon(
          _currentIcon,
        ),
      ),
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
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  label: 'Waiters'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded), label: 'Menu'),
            ]),
      ),
    );
  }

  void addItems(int index, BuildContext context) {
    showModalBottomSheet(
        backgroundColor: backgroundColor,
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
