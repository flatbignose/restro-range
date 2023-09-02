// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/size_radius.dart';

class WaiterCard extends ConsumerWidget {
  // static const routeName = '/waiterProfile';
  final String waiterName;
  final String waiterAge;
  final String waiterPic;
  final String waiterId;
  final String waiterPhone;
  final String restroName;
  final String restroId;
  final Timestamp joinDate;
  const WaiterCard({
    super.key,
    required this.joinDate,
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
    final String joined =
        DateFormat.yMMMMd().format(joinDate.toDate()).toString();
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            width: size.width * 0.95,
            height: size.height * 0.31,
            decoration: BoxDecoration(
              borderRadius: radius10,
              color: textColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 209, 202, 202),
                  Colors.white
                ], // Gradient colors
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.31,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    // border: Border.all(color: textColor, width: 10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: waiterPic,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            waiterName,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '( joined on $joined )',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      CardText(title: 'UserID : $waiterId'),
                      CardText(title: 'Age : $waiterAge'),
                      CardText(title: 'Phone Number : $waiterPhone')
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardText extends StatelessWidget {
  const CardText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
