import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd MMMM yyyy', 'id_ID');
final DateTime now = DateTime.now();
final String formattedDate = formatter.format(now);

final DateFormat day = DateFormat('EEEE', 'id_ID');
final DateTime dayNow = DateTime.now();
final String dayDate = day.format(dayNow);

Future<void> exportAbsensi(BuildContext context) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('absensi')
      .where('tanggal', isEqualTo: formattedDate)
      .get();

  List<QueryDocumentSnapshot> docs = snapshot.docs;
  final excel = Excel.createExcel();
  final sheet = excel['Absensi'];
  excel.delete('Sheet1');

  sheet.setColAutoFit(0);
  sheet.setColAutoFit(1);
  sheet.setColAutoFit(2);
  sheet.setColAutoFit(3);

  sheet.appendRow(['No', 'Izin', 'Sakit', 'Alfa', 'Tanggal']);

  final headerRow = sheet.rows.first;
  for (var cell in headerRow) {
    cell?.cellStyle = CellStyle(
      backgroundColorHex: '#BDD7EE',
      bold: true,
    );
  }

  for (var docIndex = 0; docIndex < docs.length; docIndex++) {
    var doc = docs[docIndex];
    var row = [
      docIndex + 1,
      doc['izin'],
      doc['sakit'],
      doc['alfa'],
      doc['tanggal']
    ];
    sheet.appendRow(row);
  }

  Directory? appDocumentsDirectory = await getExternalStorageDirectory();

  if (appDocumentsDirectory != null) {
    String appDocumentsPath = appDocumentsDirectory.path;

    final file =
        File('$appDocumentsPath/Laporan Absensi $dayDate, $formattedDate.xlsx');
    await file.writeAsBytes(await excel.encode()!);

    print('Export data berhasil');

    downloadFile(context, file.path);
  } else {
    print('Gagal mendapatkan direktori penyimpanan eksternal');
  }
}

Future<void> exportKeterlambatan(BuildContext context) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('keterlambatan')
      .where('tanggal', isEqualTo: formattedDate)
      .get();

  List<QueryDocumentSnapshot> docs = snapshot.docs;
  final excel = Excel.createExcel();
  final sheet = excel['Keterlambatan'];
  excel.delete('Sheet1');

  sheet.setColAutoFit(0);
  sheet.setColAutoFit(1);
  sheet.setColAutoFit(2);
  sheet.setColAutoFit(3);
  sheet.setColAutoFit(4);

  sheet.appendRow(['No', 'Nama', 'Kelas', 'Keterangan', 'Tanggal']);

  final headerRow = sheet.rows.first;
  for (var cell in headerRow) {
    cell?.cellStyle = CellStyle(
      backgroundColorHex: '#BDD7EE',
      bold: true,
    );
  }

  for (var docIndex = 0; docIndex < docs.length; docIndex++) {
    var doc = docs[docIndex];
    var row = [
      docIndex + 1,
      doc['nama'],
      doc['kelas'],
      doc['keterangan'],
      doc['tanggal']
    ];
    sheet.appendRow(row);
  }

  Directory? appDocumentsDirectory = await getExternalStorageDirectory();

  if (appDocumentsDirectory != null) {
    String appDocumentsPath = appDocumentsDirectory.path;

    final file = File(
        '$appDocumentsPath/Laporan Keterlambatan $dayDate, $formattedDate.xlsx');
    await file.writeAsBytes(await excel.encode()!);

    print('Export data berhasil');

    downloadFile(context, file.path);
  } else {
    print('Gagal mendapatkan direktori penyimpanan eksternal');
  }
}

Future<void> exportPelanggaran(BuildContext context) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('pelanggaran')
      .where('tanggal', isEqualTo: formattedDate)
      .get();

  List<QueryDocumentSnapshot> docs = snapshot.docs;
  final excel = Excel.createExcel();
  final sheet = excel['Pelanggaran'];
  excel.delete('Sheet1');

  sheet.setColAutoFit(0);
  sheet.setColAutoFit(1);
  sheet.setColAutoFit(2);
  sheet.setColAutoFit(3);
  sheet.setColAutoFit(4);

  sheet.appendRow(['No', 'Nama', 'Kelas', 'Pelanggaran', 'Tanggal']);

  final headerRow = sheet.rows.first;
  for (var cell in headerRow) {
    cell?.cellStyle = CellStyle(
      backgroundColorHex: '#BDD7EE',
      bold: true,
    );
  }

  for (var docIndex = 0; docIndex < docs.length; docIndex++) {
    var doc = docs[docIndex];
    var row = [
      docIndex + 1,
      doc['nama'],
      doc['kelas'],
      doc['pelanggaran'],
      doc['tanggal']
    ];
    sheet.appendRow(row);
  }

  Directory? appDocumentsDirectory = await getExternalStorageDirectory();

  if (appDocumentsDirectory != null) {
    String appDocumentsPath = appDocumentsDirectory.path;

    final file = File(
        '$appDocumentsPath/Laporan Pelanggaran $dayDate, $formattedDate.xlsx');
    await file.writeAsBytes(await excel.encode()!);

    print('Export data berhasil');

    downloadFile(context, file.path);
  } else {
    print('Gagal mendapatkan direktori penyimpanan eksternal');
  }
}

Future<void> exportTamu(BuildContext context) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('tamu')
      .where('tanggal', isEqualTo: formattedDate)
      .get();

  List<QueryDocumentSnapshot> docs = snapshot.docs;
  final excel = Excel.createExcel();
  final sheet = excel['Tamu'];
  excel.delete('Sheet1');

  sheet.setColAutoFit(0);
  sheet.setColAutoFit(1);
  sheet.setColAutoFit(2);
  sheet.setColAutoFit(3);
  sheet.setColAutoFit(4);
  sheet.setColAutoFit(5);
  sheet.setColAutoFit(6);

  sheet.appendRow([
    'No',
    'Nama',
    'Nama Instansi',
    'Guru Tujuan',
    'Keterangan',
    'Jam',
    'Tanggal'
  ]);

  final headerRow = sheet.rows.first;
  for (var cell in headerRow) {
    cell?.cellStyle = CellStyle(
      backgroundColorHex: '#BDD7EE',
      bold: true,
    );
  }

  for (var docIndex = 0; docIndex < docs.length; docIndex++) {
    var doc = docs[docIndex];
    var row = [
      docIndex + 1,
      doc['nama'],
      doc['instansi'],
      doc['tujuan'],
      doc['keterangan'],
      doc['jam'],
      doc['tanggal'],
    ];
    sheet.appendRow(row);
  }

  Directory? appDocumentsDirectory = await getExternalStorageDirectory();

  if (appDocumentsDirectory != null) {
    String appDocumentsPath = appDocumentsDirectory.path;

    final file = File(
        '$appDocumentsPath/Laporan Kunjungan $dayDate, $formattedDate.xlsx');
    await file.writeAsBytes(await excel.encode()!);

    print('Export data berhasil');

    downloadFile(context, file.path);
  } else {
    print('Gagal mendapatkan direktori penyimpanan eksternal');
  }
}

Future<void> exportAll(BuildContext context) async {
  QuerySnapshot absensi = await FirebaseFirestore.instance
      .collection('absensi')
      .where('tanggal', isEqualTo: formattedDate)
      .get();

  QuerySnapshot keterlambatan = await FirebaseFirestore.instance
      .collection('keterlambatan')
      .where('tanggal', isEqualTo: formattedDate)
      .get();

  QuerySnapshot pelanggaran = await FirebaseFirestore.instance
      .collection('pelanggaran')
      .where('tanggal', isEqualTo: formattedDate)
      .get();

  QuerySnapshot tamu = await FirebaseFirestore.instance
      .collection('tamu')
      .where('tanggal', isEqualTo: formattedDate)
      .get();

  List<QueryDocumentSnapshot> docsAbsensi = absensi.docs;
  List<QueryDocumentSnapshot> docsTerlambat = keterlambatan.docs;
  List<QueryDocumentSnapshot> docsPelanggaran = pelanggaran.docs;
  List<QueryDocumentSnapshot> docsTamu = tamu.docs;

  final excel = Excel.createExcel();
  final sheet = excel['Absensi'];
  final sheet2 = excel['Keterlambatan'];
  final sheet3 = excel['Pelanggaran'];
  final sheet4 = excel['Kunjungan Tamu'];
  excel.delete('Sheet1');

  sheet.setColAutoFit(0);
  sheet.setColAutoFit(1);
  sheet.setColAutoFit(2);
  sheet.setColAutoFit(3);
  sheet.setColAutoFit(4);

  sheet2.setColAutoFit(0);
  sheet2.setColAutoFit(1);
  sheet2.setColAutoFit(2);
  sheet2.setColAutoFit(3);
  sheet2.setColAutoFit(4);

  sheet3.setColAutoFit(0);
  sheet3.setColAutoFit(1);
  sheet3.setColAutoFit(2);
  sheet3.setColAutoFit(3);
  sheet3.setColAutoFit(4);

  sheet4.setColAutoFit(0);
  sheet4.setColAutoFit(1);
  sheet4.setColAutoFit(2);
  sheet4.setColAutoFit(3);
  sheet4.setColAutoFit(4);
  sheet4.setColAutoFit(5);
  sheet4.setColAutoFit(6);

  sheet.appendRow(['No', 'Izin', 'Sakit', 'Alfa', 'Tanggal']);
  sheet2.appendRow(['No', 'Nama', 'Kelas', 'Keterangan', 'Tanggal']);
  sheet3.appendRow(['No', 'Nama', 'Kelas', 'Pelanggaran', 'Tanggal']);
  sheet4.appendRow([
    'No',
    'Nama',
    'Nama Instansi',
    'Guru Tujuan',
    'Keterangan',
    'Jam',
    'Tanggal'
  ]);

  final headerAbsensi = sheet.rows.first;
  final headerKeterlambatan = sheet2.rows.first;
  final headerPelanggaran = sheet3.rows.first;
  final headerTamu = sheet4.rows.first;

  for (var cell in headerAbsensi) {
    cell?.cellStyle = CellStyle(
      backgroundColorHex: '#BDD7EE',
      bold: true,
    );
  }

  for (var cell in headerKeterlambatan) {
    cell?.cellStyle = CellStyle(
      backgroundColorHex: '#BDD7EE',
      bold: true,
    );
  }

  for (var cell in headerPelanggaran) {
    cell?.cellStyle = CellStyle(
      backgroundColorHex: '#BDD7EE',
      bold: true,
    );
  }

  for (var cell in headerTamu) {
    cell?.cellStyle = CellStyle(
      backgroundColorHex: '#BDD7EE',
      bold: true,
    );
  }

  for (var docIndex = 0; docIndex < docsAbsensi.length; docIndex++) {
    var doc = docsAbsensi[docIndex];
    var row = [
      docIndex + 1,
      doc['izin'],
      doc['sakit'],
      doc['alfa'],
      doc['tanggal']
    ];
    sheet.appendRow(row);
  }

  for (var docIndex = 0; docIndex < docsTerlambat.length; docIndex++) {
    var doc = docsTerlambat[docIndex];
    var row = [
      docIndex + 1,
      doc['nama'],
      doc['kelas'],
      doc['keterangan'],
      doc['tanggal']
    ];
    sheet2.appendRow(row);
  }

  for (var docIndex = 0; docIndex < docsPelanggaran.length; docIndex++) {
    var doc = docsPelanggaran[docIndex];
    var row = [
      docIndex + 1,
      doc['nama'],
      doc['kelas'],
      doc['pelanggaran'],
      doc['tanggal']
    ];
    sheet3.appendRow(row);
  }

  for (var docIndex = 0; docIndex < docsTamu.length; docIndex++) {
    var doc = docsTamu[docIndex];
    var row = [
      docIndex + 1,
      doc['nama'],
      doc['instansi'],
      doc['tujuan'],
      doc['keterangan'],
      doc['jam'],
      doc['tanggal'],
    ];
    sheet4.appendRow(row);
  }

  Directory? appDocumentsDirectory = await getExternalStorageDirectory();

  if (appDocumentsDirectory != null) {
    String appDocumentsPath = appDocumentsDirectory.path;

    final file =
        File('$appDocumentsPath/Laporan Keseluruhan $dayDate, $formattedDate.xlsx');
    await file.writeAsBytes(await excel.encode()!);

    print('Export data berhasil');

    downloadFile(context, file.path);
  } else {
    print('Gagal mendapatkan direktori penyimpanan eksternal');
  }
}

Future<void> downloadFile(BuildContext context, String filePath) async {
  final directory = await getExternalStorageDirectory();

  final File file = File(filePath);

  if (directory != null) {
    final String newPath = '${directory.path}/Laporan.xlsx';
    await file.copy(newPath);

    await OpenFile.open(filePath);
  } else {
    print('Gagal mendapatkan direktori penyimpanan eksternal');
  }
}
