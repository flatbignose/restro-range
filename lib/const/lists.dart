import 'package:flutter/material.dart';
import 'package:restro_range/Presentation/menu/screens/categories.dart';

import '../Presentation/menu/screens/orders.dart';
import '../Presentation/tables/screens/tables.dart';
import '../Presentation/waiters/screens/waiters.dart';

class ConstantLists {
  static const List<Widget> screens = [
    // OrderList(),
    ScreenTables(),
    ScreenWaiter(),
    ScreenCategories()
  ];

  static const List<String> restroHintList = [
    'Restaurant Name',
    'Owned By',
    'Address',
    'Phone Number'
  ];

  // static const List<String> waiterInfo = [
  //   'Name',
  //   'UserID',
  //   'Age',
  //   'Phone Number',
  //   'Join Date'
  // ];

  static const List<String> regHintList = [
    'Enter Email Address',
    'Confirm Email Address',
    'Enter Password',
    'Confirm Password'
  ];

  static const List<String> drawerList = [
    // 'Waiters Stats',
    // 'Revenue',
    'Settings',
    'About Us',
    'Privacy Policy',
    'Log Out'
  ];

  static const drawerIconsList = <IconData>[
    // Icons.supervised_user_circle_outlined,
    // Icons.bar_chart,
    Icons.settings,
    Icons.info_outline,
    Icons.security,
    Icons.logout,
  ];
}
