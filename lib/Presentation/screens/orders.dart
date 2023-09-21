// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Orders extends ConsumerStatefulWidget {
//   final String tableId;
//   final int index;
//   const Orders({
//     required this.tableId,
//     required this.index,
//   });

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _OrdersState();
// }

// class _OrdersState extends ConsumerState<Orders> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Table ${widget.index + 1} orders'),
//       ),
//       body: SafeArea(
//           child: Container(
//         child: Center(child: Text('Orders')),
//       )),
//     );
//   }
// }
