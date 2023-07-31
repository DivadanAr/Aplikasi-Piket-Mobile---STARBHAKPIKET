// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/keterlambatamModel.dart';

final CollectionReference _keterlambatan = FirebaseFirestore.instance.collection("keterlambatan");

// ignore: camel_case_types
class keterlambatan_controller {
  Future add_keterlambatan(keterlambatan_model keterlambatan) async {
    await _keterlambatan.doc().set(keterlambatan.add_data());
  }

  // Update data
  Future update_keterlambatan(keterlambatan_model keterlambatan) async {
    await _keterlambatan.doc(keterlambatan.id).set(keterlambatan.add_data());
  }


  // Delete data
  Future delete_keterlambatan(keterlambatan_model keterlambatan) async {
    await _keterlambatan.doc(keterlambatan.id).delete();
  }
}