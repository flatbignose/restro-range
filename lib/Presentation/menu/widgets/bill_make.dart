// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:restro_range/Presentation/screens/home.dart';
import 'package:restro_range/Presentation/tables/screens/tables.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/loader.dart';
import 'package:restro_range/const/size_radius.dart';
import 'package:screenshot/screenshot.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:uuid/uuid.dart';
import 'custom_tile_bill.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BillPrint extends StatefulWidget {
  final String? restroId;
  final String? waiterName;
  final int? itemLength;
  final String? tableId;
  final List<Map<String, dynamic>>? orderList;
  final Map<String, dynamic>? data;

  const BillPrint({
    this.tableId,
    Key? key,
    this.restroId,
    this.waiterName,
    this.orderList,
    this.itemLength,
    this.data,
  }) : super(key: key);

  @override
  State<BillPrint> createState() => _BillPrintState();
}

class _BillPrintState extends State<BillPrint> {
  final screeshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final Timestamp time = widget.data!['orderTime'];
    final billedTime = DateFormat.jm().format(time.toDate());
    final billedDate = DateFormat('dd-MM-yyyy').format(time.toDate());
    return Scaffold(
      backgroundColor: textColor,
      body: SafeArea(
        child: Screenshot(
          controller: screeshotController,
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: RepaintBoundary(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height20,
                  const StyledDivider(
                    lineStyle: DividerLineStyle.dashed,
                    thickness: 2,
                  ),
                  const Text(
                    'RECEIPT',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40),
                  ),
                  const StyledDivider(
                    lineStyle: DividerLineStyle.dashed,
                    thickness: 2,
                  ),
                  Column(
                    children: [
                      Text(
                        'Staff: ${widget.data!['waiterName']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Date & Time : $billedDate $billedTime',
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  const Divider(),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final itemList = widget.orderList![index];
                            return CustomTileBill(
                                lead: '${index + 1}',
                                qty: itemList['quantity'].toString(),
                                rate: itemList['foodPrice'],
                                total: itemList['total'].toString(),
                                title: itemList['foodName']);
                          },
                          itemCount: widget.itemLength,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    title: const Text(
                      'Total Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '₹${widget.data!['orderTotal'].toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Cash',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '₹${widget.data!['orderTotal'].toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Balance',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '₹${widget.data!['orderTotal'].toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  const StyledDivider(
                    lineStyle: DividerLineStyle.dotted,
                    thickness: 5,
                  ),
                  const Text(
                    'Thank You & Come Again',
                    style: TextStyle(fontSize: 25),
                  ),
                  const StyledDivider(
                    lineStyle: DividerLineStyle.dotted,
                    thickness: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: primColor,
        foregroundColor: backgroundColor,
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return Loader(title: 'Sent For Printing');
            },
          );
          setup(widget.tableId, widget.restroId, widget.data);
        },
        child: const Icon(Icons.picture_as_pdf),
      ),
    );
  }

//print page
  setup(String? tableId, String? restroId, Map<String, dynamic>? data) async {
    final Uint8List? pdfImage = await screeshotController.capture();

    final pdf = pw.Document();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = 'order_$timestamp.pdf';
    pdf.addPage(pw.Page(
        pageFormat: const PdfPageFormat(100, 200),
        build: (pw.Context context) {
          return pw.Expanded(
              child:
                  pw.Image(pw.MemoryImage(pdfImage!), fit: pw.BoxFit.contain));
        }));

    final directory = (await getExternalStorageDirectory())!.path;
    final file = File('$directory/$fileName');
    await file.writeAsBytes(await pdf.save());
    await clearOrderForCurrentTable(
      tableId,
      restroId,
      data,
    );
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return ScreenHome();
      },
    ), (route) => false);
  }

  clearOrderForCurrentTable(
      String? tableId, String? restroId, Map<String, dynamic>? data) async {
    Map<String, dynamic> emptyORders = {};
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restroId)
        .collection('orders')
        .doc(tableId)
        .delete();
    bool occupied = false;

    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restroId)
        .collection('tables')
        .doc(tableId)
        .update({'occupied': occupied});
    final uid = Uuid().v1();
    DateTime createDate = DateTime.now();
    Map<String, dynamic> bills = {
      'billId': uid,
      'orderTotal': data!['orderTotal'],
      'billDate': createDate,
      'tableId': tableId,
      'restroId': restroId,
      'waiterName': data['waiterName'],
      'waiterId': data['waiterId'],
    };
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restroId)
        .collection('bills')
        .doc(uid)
        .set(bills);
  }
}
