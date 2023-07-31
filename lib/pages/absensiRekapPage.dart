import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starbhakpiket/models/absensiModel.dart';
import 'package:starbhakpiket/models/kelasModel.dart';
import 'package:starbhakpiket/pages/myControllerPage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AbsensiRekapPage extends StatefulWidget {
  final absensi_model? absensi;
  final kelas_model? getdata;
  const AbsensiRekapPage(
      {super.key, required this.absensi, required this.getdata});

  @override
  State<AbsensiRekapPage> createState() => _AbsensiRekapPageState();
}

class _AbsensiRekapPageState extends State<AbsensiRekapPage> {
  final CollectionReference _jadwal =
      FirebaseFirestore.instance.collection('jadwal piket');
  List<String> izin = [];
  List<String> sakit = [];
  List<String> alfa = [];

  @override
  void initState() {
    super.initState();
    izin = widget.absensi!.izin!.map((izin) => izin.toString()).toList();
    sakit = widget.absensi!.sakit!.map((sakit) => sakit.toString()).toList();
    alfa = widget.absensi!.alfa!.map((alfa) => alfa.toString()).toList();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');

    final DateFormat day = DateFormat('EEEE', 'id_ID');
    final DateTime dayNow = DateTime.now();
    final String dayDate = day.format(dayNow);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 50, 40, 25),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                  Container(
                    width: 140,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 7),
                            spreadRadius: 0,
                            blurRadius: 5,
                            color: Color.fromRGBO(208, 208, 208, 1),
                          )
                        ]),
                    child: Container(
                      child: Center(
                        child: Text("Pilih Siswa",
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
            Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.getdata!.nama}",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                    ))),
                                SizedBox(height: 3),
                                Text("${widget.getdata!.guru}",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    )))
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 27,
                            decoration: BoxDecoration(
                                color: Color(0xff7F669D),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text("${widget.getdata!.jumlah} Siswa",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white))),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        color: Colors.black38,
                        height: 1.5,
                        width: double.maxFinite,
                      ),
                      Container(
                        child: Expanded(
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tanggal",
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black))),
                                  Text(
                                      "${widget.absensi!.hari}, ${widget.absensi!.tanggal}",
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.black38))),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text("Guru Yang bertugas",
                              //         style: GoogleFonts.quicksand(
                              //             textStyle: TextStyle(
                              //                 fontWeight: FontWeight.w600,
                              //                 fontSize: 16,
                              //                 color: Colors.black))),
                              //     StreamBuilder(
                              //         stream: _jadwal
                              //             .where('sesi', isEqualTo: 1)
                              //             .where('hari', isEqualTo: dayDate)
                              //             .snapshots(),
                              //         builder: (context, snapshot) {
                              //           if (!snapshot.hasData) {
                              //             return CircularProgressIndicator();
                              //           }
                              //           return ListView.builder(
                              //               padding: EdgeInsets.zero,
                              //               physics:
                              //                   NeverScrollableScrollPhysics(),
                              //               shrinkWrap: true,
                              //               itemCount:
                              //                   snapshot.data!.docs.length,
                              //               itemBuilder: (context, index) {
                              //                 final DocumentSnapshot records =
                              //                     snapshot.data!.docs[index];
                              //                 return Container(
                              //                   width: 100,
                              //                   child: Text(records['nama'],
                              //                   overflow: TextOverflow.ellipsis,
                              //                       style: GoogleFonts.quicksand(
                              //                           textStyle: TextStyle(
                              //                               fontWeight:
                              //                                   FontWeight.w500,
                              //                               fontSize: 15,
                              //                               color:
                              //                                   Colors.black38))),
                              //                 );
                              //               });
                              //         }),
                              //   ],
                              // ),
                              SizedBox(height: 15),
                              Text("Siswa Tidak Hadir",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black))),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.fromLTRB(22, 15, 22, 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 3),
                                        spreadRadius: -4,
                                        blurRadius: 7,
                                        color: Color.fromRGBO(161, 161, 161, 1),
                                      )
                                    ]),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Izin",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.black))),
                                          Text(
                                              izin.length.toString() + " siswa",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.black38))),
                                        ],
                                      ),
                                      Container(
                                        height: izin.length * 30,
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.all(0),
                                          itemCount: izin.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.only(left: 5),
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 3, left: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black45,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              height: 20,
                                              child: Text(izin[index],
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54))),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Sakit",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.black))),
                                          Text(
                                              sakit.length.toString() +
                                                  " siswa",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.black38))),
                                        ],
                                      ),
                                      Container(
                                        height: sakit.length * 30,
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.all(0),
                                          itemCount: sakit.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.only(left: 5),
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 3, left: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black45,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              height: 20,
                                              child: Text(sakit[index],
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54))),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Alfa",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.black))),
                                          Text(
                                              alfa.length.toString() + " siswa",
                                              style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.black38))),
                                        ],
                                      ),
                                      Container(
                                        height: alfa.length * 30,
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.all(0),
                                          itemCount: alfa.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.only(left: 5),
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 3, left: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black45,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              height: 20,
                                              child: Text(alfa[index],
                                                  style: GoogleFonts.quicksand(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15,
                                                          color:
                                                              Colors.black54))),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text("Dokumentasi",
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black))),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                padding: EdgeInsets.all(10),
                                width: double.maxFinite,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 3),
                                        spreadRadius: -3,
                                        blurRadius: 7,
                                        color: Color.fromRGBO(123, 123, 123, 1),
                                      )
                                    ]),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    '${widget.absensi?.foto}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Center(
              child: SizedBox(
                height: 45,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyControllerPage()));
                  },
                  child: Text("Selanjutnya"),
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
            )
          ],
        ),
      ),
    );
  }
}
