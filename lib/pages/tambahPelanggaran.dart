import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starbhakpiket/controllers/pelanggaranController.dart';
import 'package:starbhakpiket/models/pelanggaranModel.dart';
import 'package:starbhakpiket/pages/myControllerPage.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:intl/intl.dart';

class TambahPelanggaranPage extends StatefulWidget {
  const TambahPelanggaranPage({super.key});

  @override
  State<TambahPelanggaranPage> createState() => _TambahPelanggaranPageState();
}

class _TambahPelanggaranPageState extends State<TambahPelanggaranPage> {
  DateTime dateTimeSelected = DateTime.now();

  late DateTime selectedDate;

  final namaController = TextEditingController();

  void _openTimeFirst(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        saveButtonColor: Color(0xff7F669D),
        sheetCloseIconColor: Color(0xff7F669D),
        sheetCloseIcon: Icons.close_rounded,
        minuteTitleStyle: TextStyle(color: Color(0xff7F669D)),
        hourTitleStyle:
            TextStyle(color: Color(0xff7F669D), fontWeight: FontWeight.w800),
        wheelNumberSelectedStyle: TextStyle(color: Color(0xff7F669D)),
        sheetTitle: 'Pilih Jam Mulai',
        minuteTitle: 'Menit',
        hourTitle: 'Jam',
        saveButtonText: 'Simpan',
      ),
    );

    if (result != null) {
      setState(() {
        dateTimeSelected = result;
      });
    }
  }

  List<String> _listKelas = [];
  List<String> _listPelanggaran = [
    'Merokok',
    'Tawuran',
    'Berjudi',
    'Mabok',
    'Tatoan',
    'Membawa Sajam',
    'Membawa Miras',
    'Bullyng',
  ];
  String? _selectedKelas;
  String? _selectedPelanggaran;

  @override
  void initState() {
    super.initState();
    getDataKelas().then((listKelas) {
      setState(() {
        _listKelas = listKelas;
      });
    });
  }

  Future<List<String>> getDataKelas() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('kelas')
        .where('kelas', whereIn: [10, 11, 12]).get();
    return snapshot.docs.map((doc) => doc['nama'].toString()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Color.fromARGB(255, 254, 254, 254),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    ),
                    Container(
                      width: 230,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: Offset(0, 0),
                            ),
                          ]),
                      child: Center(
                        child: Text(
                          "Tambah Data Pelanggaran",
                          style: GoogleFonts.quicksand(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.all(20),
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: namaController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Masukan Nama Guru',
                              hintText: 'Awalan berhuruf kapital',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 25.0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade400)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade400),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
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
                                  fontSize: 16,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              border: Border.all(color: Colors.black38)),
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
                          'Pelanggaran',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              border: Border.all(color: Colors.black38)),
                          child: DropdownButton<String>(
                            value: _selectedPelanggaran,
                            items: _listPelanggaran.map((String value) {
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
                                _selectedPelanggaran = selectedItem;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade700,
                            ),
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Text(
                              'Pilih Pelanggaran Siswa',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
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
                          'Jam',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _openTimeFirst(context);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${DateFormat('HH:mm').format(dateTimeSelected)}',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Icon(
                                        Icons.date_range_rounded,
                                        color: Colors.grey,
                                        size: 22,
                                      )
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25.0, vertical: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                          'Tanggal',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: Colors.black38, width: 1)),
                          child: DateTimePicker(
                            calendarTitle: 'Pilih Tanggal',
                            cursorColor: Color(0xff7F669D),
                            type: DateTimePickerType.date,
                            dateMask: 'd MMM yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            onChanged: (val) => setState(
                                () => selectedDate = DateTime.parse(val)),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) {
                              if (val != null) {
                                setState(
                                    () => selectedDate = DateTime.parse(val));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          String formattedDate =
                              DateFormat('dd MMMM yyyy', 'id')
                                  .format(selectedDate);

                          final pelanggaran_add = pelanggaran_model(
                              nama: namaController.text,
                              tanggal: formattedDate,
                              kelas: _selectedKelas,
                              pelanggaran: _selectedPelanggaran,
                              jam:
                                  '${DateFormat('HH:mm').format(dateTimeSelected)}');
                          pelanggaran_controller()
                              .add_pelanggaran(pelanggaran_add);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyControllerPage()));
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
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 253, 253, 253),
    );
  }
}
