// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starbhakpiket/models/jadwalTamu.dart';

final CollectionReference _jadwalTamu = FirebaseFirestore.instance.collection("tamu");

// ignore: camel_case_types
class jadwalTamu_controller {
  // Add Data
  Future add_jadwalTamu(jadwalTamu_model jadwalTamu) async {
    await _jadwalTamu.doc().set(jadwalTamu.add_data());
  }

  // Update data
  Future update_jadwalTamu(jadwalTamu_model jadwalTamu) async {
    await _jadwalTamu.doc(jadwalTamu.id).set(jadwalTamu.add_data());
  }


  // Delete data
  Future delete_jadwalTamu(jadwalTamu_model jadwalTamu) async {
    await _jadwalTamu.doc(jadwalTamu.id).delete();
  }
}