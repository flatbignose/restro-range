import 'package:flutter/material.dart';

import '../../const/colors.dart';

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