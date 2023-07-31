// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starbhakpiket/models/jadwalPiketModel.dart';

final CollectionReference _jadwalPiket = FirebaseFirestore.instance.collection("jadwal piket");

// ignore: camel_case_types
class jadwalPiket_controller {
  // Add Data
  Future add_jadwalPiket(jadwalPiket_model jadwalPiket) async {
    await _jadwalPiket.doc().set(jadwalPiket.add_data());
  }

  // Update data
  Future update_jadwalPiket(jadwalPiket_model jadwalPiket) async {
    await _jadwalPiket.doc(jadwalPiket.id).set(jadwalPiket.add_data());
  }


  // Delete data
  Future delete_jadwalPiket(jadwalPiket_model jadwalPiket) async {
    await _jadwalPiket.doc(jadwalPiket.id).delete();
  }
}