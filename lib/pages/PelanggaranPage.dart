import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starbhakpiket/pages/tambahPelanggaran.dart';
import 'package:intl/intl.dart';

class PelanggaranPage extends StatefulWidget {
  const PelanggaranPage({super.key});

  @override
  State<PelanggaranPage> createState() => _LaporanPelanggaranState();
}

class _LaporanPelanggaranState extends State<PelanggaranPage> {
  final CollectionReference _jadwal =
      FirebaseFirestore.instance.collection('jadwal piket');

  final CollectionReference _pelanggaran =
      FirebaseFirestore.instance.collection('pelanggaran');

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    int hour = now.hour;
    int session = 0;

    if (hour >= 6 && hour <= 12) {
      session = 1;
    } else {
      session = 2;
    }

    final DateFormat day = DateFormat('EEEE', 'id_ID');
    final DateTime dayNow = DateTime.now();
    final String dayDate = day.format(dayNow);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Color(0xff7F669D),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 35, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 220,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
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
                          child: Text("Laporan Pelanggaran",
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
              SizedBox(
                width: 300,
                child: StreamBuilder(
                    stream: _jadwal
                        .where('sesi', isEqualTo: session)
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("sesi $session",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Colors.white70))),
                                Text(records['nama'],
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Colors.white))),
                              ],
                            );
                          });
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                width: 350,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(width: 1.5, color: Color.fromARGB(255, 89, 89, 89))
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                        blurRadius: 5,
                        color: Colors.black38,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Tanggal',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black87.withOpacity(0.5)))),
                        Text('${now.day}',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    color: Colors.black87)))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Bulan',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black87.withOpacity(0.5)))),
                        Text('${now.month}',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    color: Colors.black87)))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Tahun',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black87.withOpacity(0.5)))),
                        Text('${now.year}',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    color: Colors.black87)))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('jam',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black87.withOpacity(0.5)))),
                        Text('${now.hour}:${now.minute}',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    color: Colors.black87)))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 40),
                  width: double.maxFinite,
                  height: 555,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(33),
                        topRight: Radius.circular(33),
                      )),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(33),
                          topRight: Radius.circular(33),
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                              stream: _pelanggaran.snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Tidak ada kunjungan...',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff7F669D),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (snapshot.data!.docs.length == 0) {
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Tidak ada kunjungan...',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff7F669D),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot records =
                                          snapshot.data!.docs[index];
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        width: 322,
                                        decoration: BoxDecoration(
                                          color: Color(0xff7F669D),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 352,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1, horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              records['nama'],
                                                              style: GoogleFonts
                                                                  .quicksand(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              records['kelas'],
                                                              style: GoogleFonts
                                                                  .quicksand(
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        252,
                                                                        252),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        '-10',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              252,
                                                              252),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    width: 340,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      records['pelanggaran'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.transparent,
        margin: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TambahPelanggaranPage()));
          },
          child: Text("Tambah Pelanggaran",
              style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800))),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff7F669D)),
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
