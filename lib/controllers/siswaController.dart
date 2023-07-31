// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starbhakpiket/models/siswaModel.dart';

final CollectionReference _siswa = FirebaseFirestore.instance.collection("siswa");

// ignore: camel_case_types
class siswa_controller {
  // Add Data
  Future add_siswa(siswa_model siswa) async {
    await _siswa.doc().set(siswa.add_data());
  }

  // Update data
  Future update_siswa(siswa_model siswa) async {
    await _siswa.doc(siswa.id).set(siswa.add_data());
  }


  // Delete data
  Future delete_siswa(siswa_model siswa) async {
    await _siswa.doc(siswa.id).delete();
  }
}