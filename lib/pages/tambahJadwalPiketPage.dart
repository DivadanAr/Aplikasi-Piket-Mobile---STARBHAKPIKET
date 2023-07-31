import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starbhakpiket/controllers/jadwalPiketController.dart';
import 'package:starbhakpiket/models/jadwalPiketModel.dart';
import 'package:starbhakpiket/pages/myControllerPage.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:intl/intl.dart';

class TambahJadwalPiketPage extends StatefulWidget {
  const TambahJadwalPiketPage({super.key});

  @override
  State<TambahJadwalPiketPage> createState() => _TambahJadwalPiketPageState();
}

class _TambahJadwalPiketPageState extends State<TambahJadwalPiketPage> {
  DateTime dateTimeSelectedFirst = DateTime.now();
  DateTime dateTimeSelectedSec = DateTime.now();

  late DateTime selectedDate;

  final namaController = TextEditingController();
  final sesiController = TextEditingController();

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
        dateTimeSelectedFirst = result;
      });
    }
  }

  void _openTimeSec(BuildContext context) async {
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
        sheetTitle: 'Pilih Jam Akhir',
        minuteTitle: 'Menit',
        hourTitle: 'Jam',
        saveButtonText: 'Simpan',
      ),
    );

    if (result != null) {
      setState(() {
        dateTimeSelectedSec = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 90,
              padding: const EdgeInsets.only(top: 35, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Tambah Jadwal piket",
                        style: GoogleFonts.quicksand(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 0),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                  )
                ],
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
                              hintText: 'awalan berhuruf kapital',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade400)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(100.0),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade400),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(100.0),
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
                          'Jam ',
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
                                  child: Text(
                                    '${DateFormat('HH:mm').format(dateTimeSelectedFirst)}',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, 
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      side: BorderSide(
                                        color: Colors.grey, // warna border
                                        width: 1.0, 
                                      ),
                                    ),
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25.0,
                                        vertical: 14), // padding teks
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '-',
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _openTimeSec(context);
                                  },
                                  child: Text(
                                    '${DateFormat('HH:mm').format(dateTimeSelectedSec)}',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, 
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      side: BorderSide(
                                        color: Colors.grey, // warna border
                                        width: 1.0, 
                                      ),
                                    ),
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25.0,
                                        vertical: 14), // padding teks
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
                          'Sesi',
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
                          keyboardType: TextInputType.number,
                          controller: sesiController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Sesi Jadwal',
                              hintText: '1 / 2',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade400)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(100.0),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade400),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(100.0),
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
                            selectableDayPredicate: (date) {
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }
                              return true;
                            },
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
                          List<String> namaBulan = [
                            '',
                            'Januari',
                            'Februari',
                            'Maret',
                            'April',
                            'Mei',
                            'Juni',
                            'Juli',
                            'Agustus',
                            'September',
                            'Oktober',
                            'November',
                            'Desember'
                          ];
                          String currentMonthNameID =
                              namaBulan[DateTime.now().month];

                          String formattedDate =
                              DateFormat('dd MMMM yyyy', 'id')
                                  .format(selectedDate);

                          final jadwal_add = jadwalPiket_model(
                              nama: namaController.text,
                              jadwalMulai:
                                  '${DateFormat('HH:mm').format(dateTimeSelectedFirst)}',
                              jadwalAkhir:
                                  '${DateFormat('HH:mm').format(dateTimeSelectedSec)}',
                              tanggal: formattedDate,
                              bulan: currentMonthNameID,
                              sesi: int.parse(sesiController.text),
                              hari: DateFormat('EEEE', 'id')
                                  .format(selectedDate));
                          jadwalPiket_controller().add_jadwalPiket(jadwal_add);
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
    );
  }
}
