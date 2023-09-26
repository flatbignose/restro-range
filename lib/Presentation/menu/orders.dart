// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import 'package:restro_range/Presentation/menu/controller/menu_controller.dart';
import 'package:restro_range/Presentation/menu/repository/menu_repo.dart';
import 'package:restro_range/Presentation/menu/widgets/bill_make.dart';
import 'package:restro_range/Presentation/waiters/screens/waiters.dart';
import 'package:restro_range/const/colors.dart';

import '../../const/size_radius.dart';
import 'widgets/custom_tile_bill.dart';

class BillGeneration extends ConsumerStatefulWidget {
  final int tableIndex;
  final String tableId;
  const BillGeneration({
    super.key,
    required this.tableIndex,
    required this.tableId,
  });

  @override
  ConsumerState<BillGeneration> createState() => _BillGenerationState();
}

class _BillGenerationState extends ConsumerState<BillGeneration> {
  QuerySnapshot? set;
  int? length;
  @override
  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: textColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: ref.read(menuControProvider).getOrders(widget.tableId),
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
                        'Pending Orders Loading...',
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
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: radius10,
                        ),
                        width: 220,
                        height: 220,
                        child:
                            Lottie.asset('asset/lottie_files/no_orders.json')),
                  ),
                  const Text(
                    'No Orders for now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ],
              ));
            }

            return Stack(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[0];
                    final data = document.data() as Map<String, dynamic>;
                    List<dynamic> orderListDynamic = data['order'];
                    List<Map<String, dynamic>> orderList =
                        List<Map<String, dynamic>>.from(orderListDynamic);
                    final data1 = orderList[index];
                    print(orderList[index]);
                    return CustomTileBill(
                        lead: '${index + 1}',
                        qty: data1['quantity'].toString(),
                        rate: data1['foodPrice'].toString(),
                        total: data1['total'].toString(),
                        title: data1['foodName']);
                  },
                  itemCount: ref.read(menuRepoProvider).orderListLength,
                ),
                Positioned(
                  bottom: 10,
                  left: size.width * 0.20,
                  right: size.width * 0.20,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(10),
                          foregroundColor: MaterialStatePropertyAll(primColor),
                          backgroundColor:
                              MaterialStatePropertyAll(backgroundColor)),
                      onPressed: () {
                        final document = snapshot.data!.docs[0];
                        // final document1 = snapshot.data!.docs[in];
                        final data = document.data() as Map<String, dynamic>;
                        List<dynamic> orderListDynamic = data['order'];
                        List<Map<String, dynamic>> orderList =
                            List<Map<String, dynamic>>.from(orderListDynamic);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return BillPrint(
                              tableId:widget.tableId,
                              restroId: restroId,
                              itemLength:
                                  ref.read(menuRepoProvider).orderListLength,
                              orderList: orderList,
                              data: data,
                            );
                          },
                        ));
                      },
                      child: Text('Send For Billing')),
                )
              ],
            );
          }),
    );
  }
}
