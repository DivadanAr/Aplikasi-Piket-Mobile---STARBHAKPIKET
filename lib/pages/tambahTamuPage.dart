import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:starbhakpiket/controllers/jadwalTamuController.dart';
import 'package:starbhakpiket/models/jadwalTamu.dart';
import 'package:starbhakpiket/pages/myControllerPage.dart';
import 'package:starbhakpiket/pages/utils/telegramClient.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class TambahTamuPage extends StatefulWidget {
  const TambahTamuPage({super.key});

  @override
  State<TambahTamuPage> createState() => _TambahTamuPageState();
}

class _TambahTamuPageState extends State<TambahTamuPage> {
  final TelegramClient telegramClient = new TelegramClient(
    chatId: "1493837260",
    botToken: "6018012602:AAGALp_1g6U0HYKpP2KHWL2fnMMq0x2hhDM",
  );

  DateTime dateTimeSelected = DateTime.now();

  late DateTime selectedDate;

  final namaController = TextEditingController();
  final instansiController = TextEditingController();
  final tujuanController = TextEditingController();
  final keteranganController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
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
                      "Tambah Jadwal Tamu",
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
              margin: EdgeInsets.only(top: 25, bottom: 35),
              padding: EdgeInsets.all(20),
              width: 330,
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
                            labelText: 'Masukan Nama Tamu',
                            hintText: 'awalan berhuruf kapital',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25.0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade400)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey.shade400),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.red.shade700),
                            ),
                            labelStyle: const TextStyle(color: Colors.black54)),
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
                        'Nama Instansi',
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
                        controller: instansiController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Masukan Nama Instansi',
                            hintText: 'awalan berhuruf kapital',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25.0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade400)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey.shade400),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.red.shade700),
                            ),
                            labelStyle: const TextStyle(color: Colors.black54)),
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
                        'Guru Yang di Tuju',
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
                        controller: tujuanController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Masukan Nama Guru Tujuan',
                            hintText: 'awalan berhuruf kapital',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25.0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade400)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey.shade400),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.red.shade700),
                            ),
                            labelStyle: const TextStyle(color: Colors.black54)),
                      ),
                    ],
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
                                  backgroundColor: Colors
                                      .white, // warna latar belakang tombol
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                    side: BorderSide(
                                      color: Colors.grey, // warna border
                                      width: 1.0, // lebar border
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
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Keterangan',
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ))),
                      SizedBox(height: 7),
                      TextField(
                        controller: keteranganController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 113, 113, 113)),
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: Colors.black26,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      )
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
                      onPressed: () async {
                        String formattedDate = DateFormat('dd MMMM yyyy', 'id')
                            .format(selectedDate);
                        final jadwal_add = jadwalTamu_model(
                          nama: namaController.text,
                          namaInstansi: instansiController.text,
                          tujuan: tujuanController.text,
                          keterangan: keteranganController.text,
                          jam:
                              '${DateFormat('HH:mm').format(dateTimeSelected)}',
                          tanggal: formattedDate,
                        );
                        jadwalTamu_controller().add_jadwalTamu(jadwal_add);
                        final message = 'Hai ' +
                            tujuanController.text +
                            '! ' +
                            namaController.text +
                            ' dari ' +
                            instansiController.text +
                            ' ingin ' +
                            keteranganController.text +
                            ' dengan ' +
                            tujuanController.text +
                            ' pada ' +
                            formattedDate +
                            ' jam ${DateFormat('HH:mm').format(dateTimeSelected)}. ' +
                            ' Apakah ' +
                            tujuanController.text +
                            ' bersedia?, terimaKasih!';
                        final response =
                            await telegramClient.sendMessage("$message");
                        print(response.statusCode);
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
    ));
  }
}
