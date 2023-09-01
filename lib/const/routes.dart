import 'package:flutter/material.dart';
import 'package:restro_range/Presentation/screens/home.dart';
import 'package:restro_range/auth/screens/restro_details.dart';
import 'package:restro_range/auth/screens/login.dart';
import 'package:restro_range/auth/screens/registration.dart';

import '../Presentation/widgets/add_menu_item.dart';
import '../Presentation/widgets/add_waiter.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ScreenLogin.routeName:
      return MaterialPageRoute(
        builder: (context) => ScreenLogin(),
      );
    case ScreenRegistration.routeName:
      return MaterialPageRoute(
        builder: (context) => ScreenRegistration(),
      );
    case ScreenRestroDetails.routeName:
      return MaterialPageRoute(
        builder: (context) => const ScreenRestroDetails(),
      );
    case ScreenHome.routeName:
      return MaterialPageRoute(
        builder: (context) => const ScreenHome(),
      );
    case AddWaiter.routeName:
      return MaterialPageRoute(
        builder: (context) =>  AddWaiter(),
      );
    case AddMenuItem.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddMenuItem(),
      );
    // case WaiterProfile.routeName:
    //   final arguments = settings.arguments as Map<String, dynamic>;
    //   final restroId = arguments['restroId'];
    //   final restroName = arguments['restroName'];
    //   final name = arguments['waiterName'];
    //   final pic = arguments['waiterPic'];
    //   final waiterId = arguments['userId'];
    //   final phone = arguments['waiterPhone'];
    //   final age = arguments['waiterAge'];
    //   return MaterialPageRoute(
    //     builder: (context) => WaiterProfile(
    //       restroId: restroId,
    //       restroName: restroName,
    //       waiterName: name,
    //       waiterAge: age,
    //       waiterId: waiterId,
    //       waiterPhone: phone,
    //       waiterPic: pic,
    //     ),
    //   );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text(
                '"There was an error loading the screen. Please check your internet connection and try again."',
                style: TextStyle(fontSize: 30, color: Colors.red)),
          ),
        ),
      );
  }
}
