import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:starbhakpiket/pages/tambahTamuPage.dart';

class BukuTamuPage extends StatefulWidget {
  const BukuTamuPage({super.key});

  @override
  State<BukuTamuPage> createState() => _BukuTamuPageState();
}

class _BukuTamuPageState extends State<BukuTamuPage> {
  final CollectionReference _tamu =
      FirebaseFirestore.instance.collection('tamu');

  int? _selectedDay;
  int? _selectedMonth = DateTime.now().month - 1;

  String? selectDate;

  @override
  void initState() {
    super.initState();
    setState(() {
      print(selectDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    final monthFormatter = DateFormat.MMMM('id_ID');

    final now = DateTime.now();
    final List<String> monthsOfYear = List.generate(12, (int index) {
      final date = DateTime(now.year, index + 1, 1);
      return monthFormatter.format(date);
    });

    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xff7F669D),
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 350,
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
                                child: Text("Kunjungan Tamu",
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
                      margin: EdgeInsets.only(top: 15),
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Color.fromARGB(143, 127, 102, 157),
                          width: 1.5,
                        )),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 12,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedMonth = index;
                                });
                              },
                              child: Text(monthsOfYear[index],
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: _selectedMonth == index
                                        ? Color(0xff7F669D)
                                        : Colors.black54,
                                  ))),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          spreadRadius: -2,
                          blurRadius: 6,
                          color: Color.fromRGBO(246, 246, 246, 1),
                        )
                      ]),
                      child: ListView.builder(
                        itemExtent: 80,
                        scrollDirection: Axis.horizontal,
                        itemCount: daysInMonth,
                        itemBuilder: (BuildContext context, int index) {
                          final dayFormatter = DateFormat.E('id_ID');
                          final date = DateTime(now.year, now.month, index + 1);
                          final dayName = dayFormatter.format(date);
                          final today = DateTime.now().day;
                          final isClicked = (_selectedDay != null &&
                                  _selectedDay == index + 1) ||
                              (_selectedDay == null && today == index + 1);

                          final dateFormatter =
                              DateFormat('dd MMM yyyy', 'id_ID');
                          final tanggal =
                              DateTime(now.year, now.month, index + 1);
                          final formattedDate = dateFormatter.format(tanggal);

                          final cardColor =
                              isClicked ? Color(0xff7F669D) : Colors.white;
                          return Container(
                            width: 80,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_selectedDay == index + 1) {
                                    _selectedDay = null;
                                  } else {
                                    _selectedDay = index + 1;
                                    print(formattedDate);
                                    selectDate = formattedDate;
                                  }
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: cardColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text((index + 1).toString(),
                                        style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: isClicked
                                              ? Colors.white
                                              : Colors.black,
                                        ))),
                                    SizedBox(height: 8),
                                    Text(dayName,
                                        style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: isClicked
                                              ? Colors.white
                                              : Colors.black,
                                        ))),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
                        stream: _tamu
                            .where('tanggal', isEqualTo: selectDate)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                'Tidak ada kunjungan',
                              ),
                            );
                          }
                          if (snapshot.data!.docs.length == 0) {
                            return Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  'Tidak ada kunjungan...',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot records =
                                      snapshot.data!.docs[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    height: 110,
                                    width: 332,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 244, 244, 244),
                                      borderRadius: BorderRadius.circular(20),
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
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                records['instansi'],
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black26,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                records['nama'],
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                records['tujuan'],
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black26,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            records['jam'],
                                            style: GoogleFonts.quicksand(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black26,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          }
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahTamuPage()));
          },
          child: Text("Tambah Tamu",
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
