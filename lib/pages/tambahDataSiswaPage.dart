import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starbhakpiket/controllers/siswaController.dart';
import 'package:starbhakpiket/models/siswaModel.dart';
import 'package:starbhakpiket/pages/myControllerPage.dart';

class TambahSiswaPage extends StatefulWidget {
  const TambahSiswaPage({super.key});

  @override
  State<TambahSiswaPage> createState() => _TambahSiswaPageState();
}

class _TambahSiswaPageState extends State<TambahSiswaPage> {
  List<String> _listKelas = [];
  List<String> _listJurusan = [];
  List<String> _listKelamin = [
    'laki-laki',
    'perempuan',
  ];
  List<String> _listAgama = [
    'Islam',
    'Kristen Protestan',
    'Kristen Katolik',
    'Hindu',
    'Buddha',
    'Konghucu',
    'Atheis',
  ];

  String? _selectedKelas;
  String? _selectedJurusan;
  String? _selectedKelamin;
  String? _selectedAgama;

  final nisnController = TextEditingController();
  final nipdController = TextEditingController();
  final namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDataKelas().then((listKelas) {
      setState(() {
        _listKelas = listKelas;
      });
    });
    getDataJurusan().then((listJurusan) {
      setState(() {
        _listJurusan = listJurusan;
      });
    });
  }

  Future<List<String>> getDataKelas() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('kelas')
        .where('kelas', whereIn: [10, 11, 12]).get();
    return snapshot.docs.map((doc) => doc['nama'].toString()).toList();
  }

  Future<List<String>> getDataJurusan() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('kelas')
        .where('kelas', whereIn: [10, 11, 12]).get();
    final namaKelasList =
        snapshot.docs.map((doc) => doc['nama'].toString()).toList();
    final jurusanList =
        namaKelasList.map((namaKelas) => namaKelas.split(' ')[1]).toList();
    return jurusanList.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.maxFinite,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              color: Color.fromRGBO(208, 208, 208, 1),
                            )
                          ]),
                      child: Container(
                        child: Center(
                          child: Text("Tambah Data Siswa",
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 350,
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.only(top: 40, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      color: Colors.black45,
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NISN',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.black)),
                        ),
                        TextFormField(
                          controller: nisnController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Masukan Nisn Siswa',
                              hintText: 'berupa angka',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black38),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.red.shade700),
                              ),
                              labelStyle:
                                  const TextStyle(color: Colors.black54)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NIPD',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.black)),
                        ),
                        TextFormField(
                          controller: nipdController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Masukan Nipd Siswa',
                              hintText: 'Berupa angka',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black38),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.red.shade700),
                              ),
                              labelStyle:
                                  const TextStyle(color: Colors.black54)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.black)),
                        ),
                        TextFormField(
                          controller: namaController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Masukan Nama Siswa',
                              hintText: 'awalan berhuruf kapital',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black38),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.red.shade700),
                              ),
                              labelStyle:
                                  const TextStyle(color: Colors.black54)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelas',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.black)),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(color: Colors.black38)
                          ),
                          child: DropdownButton<String>(
                            value: _selectedKelas,
                            items: _listKelas.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? selectedItem) {
                              setState(() {
                                _selectedKelas = selectedItem;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade700,
                            ),
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Text(
                              'Pilih Kelas Siswa',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jurusan',
                              style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.black)),
                            ),
                            Container(
                              width: 300,
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.black45,
                                  )),
                              child: DropdownButton<String>(
                                value: _selectedJurusan,
                                items: _listJurusan.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? selectedItem) {
                                  setState(() {
                                    _selectedJurusan = selectedItem;
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey.shade700,
                                ),
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: Text(
                                  'Pilih Jurusan Siswa',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Kelamin',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.black)),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: DropdownButton<String>(
                            value: _selectedKelamin,
                            items: _listKelamin.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? selectedItem) {
                              setState(() {
                                _selectedKelamin = selectedItem;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade700,
                            ),
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Text(
                              'Pilih Jenis Kelamin Siswa',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Agama',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.black)),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(color: Colors.black38,)
                          ),
                          child: DropdownButton<String>(
                            value: _selectedAgama,
                            items: _listAgama.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? selectedItem) {
                              setState(() {
                                _selectedAgama = selectedItem;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade700,
                            ),
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Text(
                              'Pilih Agama Siswa',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              print(namaController.text);
                              print(nisnController.text);
                              print(nipdController.text);
                              print(_selectedJurusan);
                              print(_selectedKelamin);
                              print(_selectedKelas);
                              print(_selectedAgama);
                              // final siswa_add = siswa_model(
                              //     nama: namaController.text,
                              //     nisn: nisnController.text,
                              //     nipd: nipdController.text,
                              //     kelas: _selectedKelas,
                              //     jurusan: _selectedJurusan,
                              //     kelamin: _selectedKelamin,
                              //     agama: _selectedAgama);
                              // siswa_controller().add_siswa(siswa_add);
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyControllerPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff7F669D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Simpan',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
