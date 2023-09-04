import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controllers/auth_controller.dart';
import '../../const/colors.dart';
import '../../const/lists.dart';
import '../../models/restaurant_model.dart';
import 'dialogs_functions.dart';
import 'drawer_list.dart';

class RestroDrawer extends StatelessWidget {
  const RestroDrawer({
    super.key,
    required this.ref,
    required this.size,
  });

  final WidgetRef ref;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            children: List.generate(6, (index) {
              return GestureDetector(
                onTap: () async {
                  if (index == 5) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return LogOutPop(size: size);
                      },
                    );
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
    );
  }
}

