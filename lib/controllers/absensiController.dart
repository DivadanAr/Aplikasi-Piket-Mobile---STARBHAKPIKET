// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starbhakpiket/models/absensiModel.dart';

final CollectionReference _absensi = FirebaseFirestore.instance.collection("absensi");

// ignore: camel_case_types
class absensi_controller {
  // Add Data
  Future add_absensi(absensi_model absensi) async {
    await _absensi.doc().set(absensi.add_data());
  }

  // Update data
  Future update_absensi(absensi_model absensi) async {
    await _absensi.doc(absensi.id).set(absensi.add_data());
  }


  // Delete data
  Future delete_absensi(absensi_model absensi) async {
    await _absensi.doc(absensi.id).delete();
  }
}