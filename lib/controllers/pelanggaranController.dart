// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pelanggaranModel.dart';

final CollectionReference _pelanggaran = FirebaseFirestore.instance.collection("pelanggaran");

// ignore: camel_case_types
class pelanggaran_controller {
  // Add Data
  Future add_pelanggaran(pelanggaran_model pelanggaran) async {
    await _pelanggaran.doc().set(pelanggaran.add_data());
  }

  // Update data
  Future update_pelanggaran(pelanggaran_model pelanggaran) async {
    await _pelanggaran.doc(pelanggaran.id).set(pelanggaran.add_data());
  }


  // Delete data
  Future delete_pelanggaran(pelanggaran_model pelanggaran) async {
    await _pelanggaran.doc(pelanggaran.id).delete();
  }
}

