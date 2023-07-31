import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:starbhakpiket/pages/tambahJadwalPiketPage.dart';
import 'package:day_picker/day_picker.dart';

class JadwalPiketPage extends StatefulWidget {
  const JadwalPiketPage({super.key});

  @override
  State<JadwalPiketPage> createState() => _JadwalPiketPageState();
}

class _JadwalPiketPageState extends State<JadwalPiketPage> {
  final CollectionReference _jadwal =
      FirebaseFirestore.instance.collection('jadwal piket');

  List<String?> _selectedDay = [];

  @override
  Widget build(BuildContext context) {

    final DateFormat day = DateFormat('EEEE', 'id_ID');
    final DateTime dayNow = DateTime.now();
    final String dayDate = day.format(dayNow);

    bool senin = false;
    bool selasa = false;
    bool rabu = false;
    bool kamis = false;
    bool jumat = false;
    bool sabtu = false;

    if (DateFormat.EEEE('id_ID').format(DateTime.now()) == 'Senin') {
      senin = true;
    } else if (DateFormat.EEEE('id_ID').format(DateTime.now()) == 'Selasa') {
      selasa = true;
    } else if (DateFormat.EEEE('id_ID').format(DateTime.now()) == 'Rabu') {
      rabu = true;
    } else if (DateFormat.EEEE('id_ID').format(DateTime.now()) == 'Kamis') {
      kamis = true;
    } else if (DateFormat.EEEE('id_ID').format(DateTime.now()) == 'Jumat') {
      jumat = true;
    } else if (DateFormat.EEEE('id_ID').format(DateTime.now()) == 'Sabtu') {
      sabtu = true;
    } else {
      senin = false;
      selasa = false;
      rabu = false;
      kamis = false;
      jumat = false;
      sabtu = false;
    }

    List<DayInWeek> _days = [
      DayInWeek("Senin", isSelected: senin),
      DayInWeek("Selasa", isSelected: selasa),
      DayInWeek("Rabu", isSelected: rabu),
      DayInWeek("Kamis", isSelected: kamis),
      DayInWeek("Jumat", isSelected: jumat),
      DayInWeek("Sabtu", isSelected: sabtu),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xff7F669D),
          width: double.maxFinite,
          child: Column(
            children: [
              // Text(),
              Container(
                width: double.maxFinite,
                height: 240,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                // border: Border.all(width: 1.5, color: Color.fromARGB(255, 89, 89, 89))
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    color: Colors.black38,
                                  )
                                ]),
                            child: Container(
                              child: Center(
                                child: Text("Jadwal Piket",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectWeekDays(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            days: _days,
                            border: false,
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: [
                                  const Color(0xff7F669D),
                                  const Color(0xff7F669D)
                                ],
                                tileMode: TileMode
                                    .repeated, // repeats the gradient over the canvas
                              ),
                            ),
                            onSelect: (values) {
                              print(values);
                              setState(() {
                                _selectedDay = values;
                                print(_selectedDay);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 35, horizontal: 30),
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: _jadwal
                            .where('sesi', isEqualTo: 1)
                            .where('hari', isEqualTo: dayDate)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot records =
                                    snapshot.data!.docs[index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 7),
                                      height: 120,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 244, 244, 244),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: RotatedBox(
                                        quarterTurns: 3,
                                        child: Text("Sesi 1",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ))),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      height: 120,
                                      width: 290,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 244, 244, 244),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  records['nama'],
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '31 Kelas (329 siswa)',
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  records['jadwal mulai'] +
                                                      '-' +
                                                      records['jadwal akhir'],
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Icon(
                                              Icons.check_circle_rounded,
                                              size: 30,
                                              color: Color(0xff00726D),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              });
                        }),
                    SizedBox(height: 25),
                    StreamBuilder(
                        stream: _jadwal
                            .where('sesi', isEqualTo: 2)
                            .where('hari', isEqualTo: dayDate)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot records =
                                    snapshot.data!.docs[index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 18),
                                      padding: const EdgeInsets.only(left: 7),
                                      height: 120,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 244, 244, 244),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: RotatedBox(
                                        quarterTurns: 3,
                                        child: Text("Sesi 2",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.quicksand(
                                                textStyle: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ))),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      height: 120,
                                      width: 290,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 244, 244, 244),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  records['nama'],
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '31 Kelas (329 siswa)',
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  records['jadwal mulai'] +
                                                      '-' +
                                                      records['jadwal akhir'],
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Icon(
                                              Icons.check_circle_rounded,
                                              size: 30,
                                              color: Color(0xff00726D),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              });
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff7F669D),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TambahJadwalPiketPage()));
          },
          child: Text("Tambah Jadwal Piket",
              style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w800))),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 255, 255, 255)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
