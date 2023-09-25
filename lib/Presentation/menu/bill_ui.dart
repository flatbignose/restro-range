// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restro_range/Presentation/menu/controller/menu_controller.dart';
import 'package:restro_range/Presentation/menu/repository/menu_repo.dart';
import 'package:restro_range/const/colors.dart';

import '../../const/size_radius.dart';

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
                      child: Image.asset(
                        'asset/images/empty_waiters.png',
                        fit: BoxFit.cover,
                      ),
                    ),
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

            return ListView.builder(
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
            );
          }),
    );
  }
}

class CustomTileBill extends ConsumerStatefulWidget {
  final WidgetRef? ref;
  final String lead;
  final String qty;
  final String rate;
  final String total;
  final String title;
  const CustomTileBill({
    Key? key,
    this.ref,
    required this.lead,
    required this.qty,
    required this.rate,
    required this.total,
    required this.title,
    this.index,
  }) : super(key: key);

  final int? index;
  @override
  ConsumerState<CustomTileBill> createState() => _CustomTileBillState();
}

class _CustomTileBillState extends ConsumerState<CustomTileBill> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        widget.lead,
        style: TextStyle(fontSize: 18),
      ),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    int quantity = int.parse(widget.qty.trim());
                    return AlertDialog(
                      title: Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {
                              // ref
                              //     .watch(repoProvider)
                              //     .increaseOrder(widget.index!);
                              // setState(() {});
                            },
                            icon: Icon(Icons.add)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit)),
                      ],
                    );
                  },
                );
              },
              child: Text(
                widget.qty,
                style: TextStyle(fontSize: 18),
              )),
          width20,
          Text(
            widget.rate,
            style: TextStyle(fontSize: 18),
          ),
          width20,
          Text(
            widget.total,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
