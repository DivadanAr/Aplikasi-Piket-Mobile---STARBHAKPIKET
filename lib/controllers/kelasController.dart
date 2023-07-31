// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starbhakpiket/models/kelasModel.dart';

final CollectionReference _kelas = FirebaseFirestore.instance.collection("kelas");

// ignore: camel_case_types
class kelas_controller {
  // Add Data
  Future add_kelas(kelas_model kelas) async {
    await _kelas.doc().set(kelas.add_data());
  }

  // Update data
  Future update_kelas(kelas_model kelas) async {
    await _kelas.doc(kelas.id).set(kelas.add_data());
  }


  // Delete data
  Future delete_kelas(kelas_model kelas) async {
    await _kelas.doc(kelas.id).delete();
  }
}