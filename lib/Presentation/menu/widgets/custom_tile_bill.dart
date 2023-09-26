import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/size_radius.dart';

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
          Text(
            widget.qty,
            style: const TextStyle(fontSize: 18),
          ),
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