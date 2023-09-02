import 'package:flutter/material.dart';

import '../Presentation/screens/menu.dart';
import '../Presentation/tables/screens/tables.dart';
import '../Presentation/waiters/screens/waiters.dart';

class ConstantLists {
  static const List<Widget> screens = [
    ScreenTables(),
    ScreenWaiter(),
    ScreenMenu()
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
    'Re-Enter Email Address',
    'Enter Password',
    'Re-Enter Password'
  ];

  static const List<String> drawerList = [
    'Revenue',
    'Settings',
    'About Us',
    'Privacy Policy',
    'Log Out'
  ];

  static const drawerIconsList = <IconData>[
    Icons.bar_chart,
    Icons.settings,
    Icons.info_outline,
    Icons.contact_page_rounded,
    Icons.logout,
  ];
}
