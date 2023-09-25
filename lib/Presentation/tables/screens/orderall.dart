// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/colors.dart';
import '../../../const/size_radius.dart';

class OrderList extends ConsumerStatefulWidget {
  final String tableId;
  final String waiterId;
  final String restroId;
  final String waiterName;
  final int index;
  const OrderList({
    super.key,
    required this.tableId,
    required this.waiterId,
    required this.restroId,
    required this.waiterName,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => OrderListState();
}

class OrderListState extends ConsumerState<OrderList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final rest = ref.read(repoProvider).orderList;
    // final grandTotal = ref.read(repoProvider).grandTotal.toString();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              height20,
              height20,
              CustomTileBill(
                ref: ref,
                lead: 'Sl',
                title: 'Item',
                qty: 'Qty',
                rate: 'Rate',
                total: 'Total',
              ),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('restaurants')
                        .doc(widget.restroId)
                        .collection('tables')
                        .doc(widget.tableId)
                        .collection('orders')
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshots.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final snap = snapshots.data!.docs[0];
                      final document = snap.data() as Map<String, dynamic>;
                      final listOrders = document['orderList'];
                      listOrders.removeAt(0);
                      // ref.read(repoProvider).grandtotalChnage();
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final data = listOrders[index];
                            // double total = data['total'];
                            // ref.read(repoProvider).increasegrand(total);
                            return Container(
                                width: size.width * 0.95,
                                height: size.height * 0.07,
                                color: textColor,
                                child: InkWell(
                                  // onLongPress: () {
                                  //   ref
                                  //       .read(repoProvider)
                                  //       .deletesingleItem(index);
                                  //   setState(() {});
                                  // },
                                  child: CustomTileBill(
                                      ref: ref,
                                      index: index,
                                      lead: '${index + 1}.',
                                      qty: data['quantity'].toString(),
                                      rate: data['foodPrice'].toString(),
                                      total: data['total'].toString(),
                                      title: data['foodName']),
                                ));
                          },
                          itemCount: listOrders.length,
                        ),
                      );
                    }),
              ),
              // SizedBox(
              //   height: size.height * 0.10,
              // )
            ],
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 20,
            child: Container(
              width: size.width,
              height: size.height * 0.07,
              decoration: const BoxDecoration(
                  color: backgroundColor, borderRadius: radius20),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Grand Total',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    Text(
                      ':',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),

                    Text(
                      'grandTotal',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       ref.watch(repoProvider).showOrder(
                    //           context: context,
                    //           restroId: widget.restroId,
                    //           tableId: widget.tableId,
                    //           waiterId: widget.waiterId,
                    //           waiterName: widget.waiterName);
                    //       Navigator.pop(context);
                    //       setState(() {});
                    //     },
                    //     icon: Icon(
                    //       Icons.done_all,
                    //       color: Colors.red,
                    //     ))
                  ]),
            ),
          ),
        ],
      ),
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
        style: const TextStyle(fontSize: 18),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 18),
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
                        style: const TextStyle(fontSize: 18),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {
                              // ref
                              //     .watch(repoProvider)
                              //     .increaseOrder(widget.index!);
                              // setState(() {});
                            },
                            icon: const Icon(Icons.add)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.abc)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.ac_unit)),
                      ],
                    );
                  },
                );
              },
              child: Text(
                widget.qty,
                style: const TextStyle(fontSize: 18),
              )),
          width20,
          Text(
            widget.rate,
            style: const TextStyle(fontSize: 18),
          ),
          width20,
          Text(
            widget.total,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
