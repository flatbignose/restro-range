// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restro_range/Presentation/tables/repository/table_repo.dart';

final tableControlProvider = Provider((ref) {
  final tableRepo = ref.watch(tableRepoProvider);
  return TableControl(tableRepo: tableRepo, ref: ref);
});

class TableControl {
  final TableRepo tableRepo;
  final ProviderRef ref;
  TableControl({
    required this.tableRepo,
    required this.ref,
  });

  Future<dynamic> deleteTable(BuildContext context, int index, tableId) async {
    await tableRepo.delete(context, index, tableId);
  }

  Future<dynamic> addTable() async {
    await tableRepo.addTableToFirebase();
  }

  Future<dynamic> updateTable(Map<String, dynamic> data) async {
    await tableRepo.updateTableFirebase(data);
  }
}
