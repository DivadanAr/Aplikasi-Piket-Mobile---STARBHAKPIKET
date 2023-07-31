// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:d_chart/d_chart.dart';
import 'package:starbhakpiket/pages/JadwalPiketPage.dart';
import 'package:starbhakpiket/pages/PelanggaranPage.dart';
import 'package:starbhakpiket/pages/bukuTamuPage.dart';
import 'package:starbhakpiket/pages/dataSiswaPage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'utils/date.dart' as date_util;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _jadwal =
      FirebaseFirestore.instance.collection('jadwal piket');
  final user = FirebaseAuth.instance.currentUser!;

  double width = 0.0;
  double height = 0.0;
 
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController(
      text: DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now()));
  final DateFormat formatter = DateFormat('d MMMM yyyy');

  int _jumlahKelas = 0;
  int _jumlahAbsensi = 0;

  @override
  void initState() {
    super.initState();
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 57.3 * currentDateTime.day);
    _getJumlahKelas();
    _getJumlahAbsensi();
  }

  Future<void> _getJumlahKelas() async {
    final QuerySnapshot kelasSnap =
        await FirebaseFirestore.instance.collection('kelas').get();
    setState(() {
      _jumlahKelas = kelasSnap.size;
    });
  }

  Future<void> _getJumlahAbsensi() async {
    final QuerySnapshot absensiSnap = await FirebaseFirestore.instance
        .collection('absensi')
        .where('tanggal', isEqualTo: controller.text)
        .get();
    setState(() {
      _jumlahAbsensi = absensiSnap.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');

    final DateFormat day = DateFormat('EEEE', 'id_ID');
    final DateTime dayNow = DateTime.now();
    final String dayDate = day.format(dayNow);

    DateTime now = DateTime.now();
    int hour = now.hour;
    String session = '';

    if (hour >= 6 && hour <= 12) {
      session = 'Sesi 1';
    } else if (hour > 12 && hour <= 18) {
      session = 'Sesi 2';
    } else {
      session = 'Libur';
    }

    final DateFormat month = DateFormat('MMMM', 'id_ID');
    final DateTime monthNow = DateTime.now();
    final String monthDate = month.format(monthNow);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 4),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Stack(children: <Widget>[
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(top: 25, left: 30, right: 30),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          return Text(
                                            'Selamat Datang '+records['nama'],
                                            style: GoogleFonts.quicksand(
                                                textStyle: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87)),
                                          );
                                        });
                                  }),
                              const SizedBox(height: 2),
                              Text('Ada apa hari ini?',
                                  style: GoogleFonts.quicksand(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)))
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 70, left: 30, right: 30),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 90),
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xffDEBACE),
                                Colors.white.withOpacity(0)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 300),
                            width: 150,
                            height: 150,
                            child: ListView.builder(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentMonthList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          final String formattedDate =
                                              formatter.format(currentDateTime);
                                          final double offsetToCenter = (64.5 *
                                                  currentMonthList[index].day) -
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) +
                                              (60 / 2);

                                          controller.text = formattedDate;
                                          currentDateTime =
                                              currentMonthList[index];
                                        });
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 12),
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              colors: (currentMonthList[index]
                                                          .day !=
                                                      currentDateTime.day)
                                                  ? [
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.transparent
                                                    ]
                                                  : [
                                                      const Color(0xff7F669D)
                                                          .withOpacity(0.8),
                                                      const Color(0xff7F669D)
                                                          .withOpacity(0.7),
                                                      const Color(0xff7F669D)
                                                          .withOpacity(0.6)
                                                    ],
                                              begin: const FractionalOffset(
                                                  0.0, 0.0),
                                              end: const FractionalOffset(
                                                  0.0, 1.0),
                                              stops: const [0.0, 0.5, 1.0],
                                              tileMode: TileMode.clamp),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                currentMonthList[index]
                                                    .day
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        (currentMonthList[index]
                                                                    .day !=
                                                                currentDateTime
                                                                    .day)
                                                            ? Colors.black
                                                            : Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ]),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('absensi')
                            .where('tanggal', isEqualTo: controller.text)
                            .snapshots(),
                        builder: (context, snapshot) {
                          int sakitCount = snapshot.data?.docs
                                  .where((doc) => doc['sakit'] != null)
                                  .map<int>((doc) => doc['sakit'].length)
                                  .fold<int>(
                                      0, (prev, count) => prev + count) ??
                              0;
                          int izinCount = snapshot.data?.docs
                                  .where((doc) => doc['izin'] != null)
                                  .map<int>((doc) => doc['izin'].length)
                                  .fold<int>(
                                      0, (prev, count) => prev + count) ??
                              0;
                          int alfaCount = snapshot.data?.docs
                                  .where((doc) => doc['alfa'] != null)
                                  .map<int>((doc) => doc['alfa'].length)
                                  .fold<int>(
                                      0, (prev, count) => prev + count) ??
                              0;

                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 95),
                            width: 350,
                            height: 140,
                            decoration: BoxDecoration(
                              color: const Color(0xff7F669D),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(1.0, 1.0),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.4,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            const Color(0xffBA94D1),
                                            const Color(0xffBA94D1)
                                                .withOpacity(0)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: const Image(
                                                image: AssetImage(
                                                    'assets/images/sakit.png')),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Sakit',
                                            style: GoogleFonts.quicksand(
                                                textStyle: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white)),
                                          )
                                        ],
                                      ),
                                      Text(sakitCount.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                fontSize: 45,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            const Color(0xffBA94D1),
                                            const Color(0xffBA94D1)
                                                .withOpacity(0)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: const Image(
                                                image: AssetImage(
                                                    'assets/images/izin.png')),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Izin',
                                            style: GoogleFonts.quicksand(
                                                textStyle: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white)),
                                          )
                                        ],
                                      ),
                                      Text(izinCount.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                fontSize: 45,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            const Color(0xffBA94D1),
                                            const Color(0xffBA94D1)
                                                .withOpacity(0)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: const Image(
                                                image: AssetImage(
                                                    'assets/images/alfa.png')),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Alfa',
                                            style: GoogleFonts.quicksand(
                                                textStyle: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white)),
                                          )
                                        ],
                                      ),
                                      Text(alfaCount.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                fontSize: 45,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 330, left: 30, right: 35),
                padding: const EdgeInsets.all(20),
                width: 350,
                height: 120,
                decoration: const BoxDecoration(
                    color: Color(0xff7F669D),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kelas Yang Harus di Absen',
                          style: GoogleFonts.quicksand(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ),
                        Text(session,
                            style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          margin: const EdgeInsets.only(top: 10),
                          width: 230,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Color(0xffF8E9F1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            '$_jumlahAbsensi dari $_jumlahKelas kelas',
                            style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(10),
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffF8E9F1),
                          ),
                          child: const Image(
                              image: AssetImage('assets/images/next.png')),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 465, left: 35, right: 35),
                alignment: Alignment.topLeft,
                child: Text(
                  'Statistik Kehadiran Siswa',
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('absensi')
                      .where('bulan', isEqualTo: monthDate)
                      .snapshots(),
                  builder: (context, snapshot) {
                    int sakitCount = snapshot.data?.docs
                            .where((doc) => doc['sakit'] != null)
                            .map<int>((doc) => doc['sakit'].length)
                            .fold<int>(0, (prev, count) => prev + count) ??
                        0;
                    int izinCount = snapshot.data?.docs
                            .where((doc) => doc['izin'] != null)
                            .map<int>((doc) => doc['izin'].length)
                            .fold<int>(0, (prev, count) => prev + count) ??
                        0;
                    int alfaCount = snapshot.data?.docs
                            .where((doc) => doc['alfa'] != null)
                            .map<int>((doc) => doc['alfa'].length)
                            .fold<int>(0, (prev, count) => prev + count) ??
                        0;

                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 495, left: 35),
                          width: 180,
                          height: 185,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.4,
                                )
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Stack(
                            children: [
                              DChartPie(
                                data: [
                                  {'domain': 'izin', 'measure': izinCount},
                                  {'domain': 'sakit', 'measure': sakitCount},
                                  {'domain': 'alfa', 'measure': alfaCount},
                                ],
                                fillColor: (pieData, index) {
                                  switch (pieData['domain']) {
                                    case 'izin':
                                      return const Color(0xffDEBACE);
                                    case 'sakit':
                                      return const Color(0xff7F669D);
                                    case 'alfa':
                                      return const Color(0xffBA94D1);

                                    default:
                                      return Colors.grey;
                                  }
                                },
                                donutWidth: 12,
                                showLabelLine: false,
                                labelColor: Colors.transparent,
                              ),
                              Align(
                                  child: Text(
                                monthDate,
                                style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800)),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 495, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 142.5,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 2.0,
                                        spreadRadius: 0.4,
                                      )
                                    ]),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 3 / 6,
                                        child: Stack(
                                          children: [
                                            DChartPie(
                                              data: [
                                                {
                                                  'domain': 'izin',
                                                  'measure': izinCount
                                                },
                                                {
                                                  'domain': 'sakit',
                                                  'measure': sakitCount
                                                },
                                                {
                                                  'domain': 'alfa',
                                                  'measure': alfaCount
                                                },
                                              ],
                                              fillColor: (pieData, index) {
                                                switch (pieData['domain']) {
                                                  case 'izin':
                                                    return Color(0xffDEBACE);

                                                  default:
                                                    return Colors.grey;
                                                }
                                              },
                                              donutWidth: 3,
                                              labelColor: Colors.transparent,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Izin',
                                        style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 142.5,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 2.0,
                                        spreadRadius: 0.4,
                                      )
                                    ]),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 3 / 6,
                                        child: Stack(
                                          children: [
                                            DChartPie(
                                              data: [
                                                {
                                                  'domain': 'izin',
                                                  'measure': 30
                                                },
                                                {
                                                  'domain': 'sakit',
                                                  'measure': 40
                                                },
                                                {
                                                  'domain': 'alfa',
                                                  'measure': 30
                                                },
                                              ],
                                              fillColor: (pieData, index) {
                                                switch (pieData['domain']) {
                                                  case 'sakit':
                                                    return Color(0xff7F669D);

                                                  default:
                                                    return Colors.grey;
                                                }
                                              },
                                              donutWidth: 3,
                                              labelColor: Colors.transparent,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Sakit',
                                        style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 142.5,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 2.0,
                                        spreadRadius: 0.4,
                                      )
                                    ]),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 3 / 6,
                                        child: Stack(
                                          children: [
                                            DChartPie(
                                              data: [
                                                {
                                                  'domain': 'izin',
                                                  'measure': izinCount
                                                },
                                                {
                                                  'domain': 'sakit',
                                                  'measure': sakitCount
                                                },
                                                {
                                                  'domain': 'alfa',
                                                  'measure': alfaCount
                                                },
                                              ],
                                              fillColor: (pieData, index) {
                                                switch (pieData['domain']) {
                                                  case 'alfa':
                                                    return Color(0xffBA94D1);
                                                  default:
                                                    return Colors.grey;
                                                }
                                              },
                                              donutWidth: 3,
                                              labelColor: Colors.transparent,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Alfa',
                                        style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalPiketPage())),
                          child: Container(
                            margin: EdgeInsets.only(top: 710, left: 35),
                            width: 168,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color(0xff7F669D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.4,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                        'assets/images/schedule.png')),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Jadwal Piket',
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DataSiswaPage())),
                          child: Container(
                            margin: EdgeInsets.only(top: 710, left: 10),
                            width: 168,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color(0xff7F669D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.4,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                        'assets/images/students-cap.png')),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Data Siswa',
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BukuTamuPage())),
                          child: Container(
                            margin: EdgeInsets.only(top: 10, left: 35),
                            width: 168,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color(0xff7F669D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.4,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                        'assets/images/guest-list.png')),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Buku Tamu',
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PelanggaranPage())),
                          child: Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            width: 168,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Color(0xff7F669D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.4,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                        'assets/images/violence.png')),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Pelanggaran Siswa',
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
