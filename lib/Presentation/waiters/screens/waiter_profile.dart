// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/size_radius.dart';

import '../widgets/text_widget.dart';

class WaiterProfile extends ConsumerWidget {
  // static const routeName = '/waiterProfile';
  final String waiterName;
  final String waiterAge;
  final String waiterPic;
  final String waiterId;
  final String waiterPhone;
  final String restroName;
  final String restroId;
  const WaiterProfile({
    super.key,
    required this.waiterName,
    required this.waiterAge,
    required this.waiterPic,
    required this.waiterId,
    required this.waiterPhone,
    required this.restroName,
    required this.restroId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: size.width / 4,
                    height: size.width / 4,
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: primColor),
                      borderRadius: radius10,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: waiterPic,
                      fit: BoxFit.cover,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      waiterName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: textColor, borderRadius: radius10),
                        child: const Text('Employee Since April 2023')),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(titlevalue: waiterId, title: 'UserID'),
                  const SizedBox(height: 20),
                  TextWidget(titlevalue: waiterAge, title: 'Age'),
                  const SizedBox(height: 20),
                  const TextWidget(titlevalue: 'Male', title: 'Gender'),
                  const SizedBox(height: 20),
                  TextWidget(titlevalue: waiterPhone, title: 'Phone'),
                ],
              ),
            ),
          ],
        ),
        //     Column(
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         Container(
        //           width: size.width / 4,
        //           height: size.width / 4,
        //           decoration: BoxDecoration(
        //             border: Border.all(width: 5, color: primColor),
        //             borderRadius: radius10,
        //           ),
        //           child: Image.asset('asset/images/waiter.png'),
        //         ),
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             const Text(
        //               'Sahil Saleem',
        //               style: TextStyle(
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             Container(
        //                 padding: const EdgeInsets.all(5),
        //                 decoration: const BoxDecoration(
        //                     color: textColor, borderRadius: radius10),
        //                 child: const Text('Employee Since April 2023')),
        //           ],
        //         )
        //       ],
        //     ),
        //     const Column()
        //   ],
        // )
      ),
    );
  }
}
