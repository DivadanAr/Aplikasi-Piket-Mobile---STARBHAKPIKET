import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starbhakpiket/pages/tambahDataSiswaPage.dart';

class DataSiswaPage extends StatefulWidget {
  const DataSiswaPage({super.key});

  @override
  State<DataSiswaPage> createState() => _DataSiswaPageState();
}

class _DataSiswaPageState extends State<DataSiswaPage> {
  int _jumlahKelas = 0;
  int _jumlahKelas10 = 0;
  int _jumlahKelas11 = 0;
  int _jumlahKelas12 = 0;

  @override
  void initState() {
    super.initState();
    _getJumlahKelas();
    _getJumlahkelas10();
    _getJumlahkelas11();
    _getJumlahkelas12();
  }

  Future<void> _getJumlahKelas() async {
    final QuerySnapshot kelasSnap =
        await FirebaseFirestore.instance.collection('siswa').get();
    setState(() {
      _jumlahKelas = kelasSnap.size;
    });
  }

  Future<void> _getJumlahkelas10() async {
    final QuerySnapshot kelasSnap = await FirebaseFirestore.instance
        .collection('siswa')
        .where('angkatan', isEqualTo: '10')
        .get();
    setState(() {
      _jumlahKelas10 = kelasSnap.size;
    });
  }

  Future<void> _getJumlahkelas11() async {
    final QuerySnapshot kelasSnap = await FirebaseFirestore.instance
        .collection('siswa')
        .where('angkatan', isEqualTo: '11')
        .get();
    setState(() {
      _jumlahKelas11 = kelasSnap.size;
    });
  }

  Future<void> _getJumlahkelas12() async {
    final QuerySnapshot kelasSnap = await FirebaseFirestore.instance
        .collection('siswa')
        .where('angkatan', isEqualTo: '12')
        .get();
    setState(() {
      _jumlahKelas12 = kelasSnap.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    int jumlah10 = _jumlahKelas11+_jumlahKelas12;
    int jumlah11 = _jumlahKelas10+_jumlahKelas11;
    int jumlah12 = _jumlahKelas11+_jumlahKelas10;
    
    double kelas10 = (_jumlahKelas10 / jumlah10) * 100;
    double kelas11 = (_jumlahKelas11 / jumlah11) * 100;
    double kelas12 = (_jumlahKelas12 / jumlah12) * 100;

    String persentaseKelas10 = kelas10.toStringAsFixed(0);
    String persentaseKelas11 = kelas11.toStringAsFixed(0);
    String persentaseKelas12 = kelas12.toStringAsFixed(0);


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xff7F669D),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 45, left: 30, right: 30),
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
                          child: Text("Data Siswa",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 16,
                          child: Stack(
                            children: [
                              DChartPie(
                                data: [
                                  {
                                    'domain': 'XII',
                                    'measure': _jumlahKelas10 + _jumlahKelas12
                                  },
                                  {'domain': 'XI', 'measure': _jumlahKelas11},
                                ],
                                fillColor: (pieData, index) {
                                  switch (pieData['domain']) {
                                    case 'XI':
                                      return Color(0xff7F669D);

                                    default:
                                      return Colors.grey;
                                  }
                                },
                                showLabelLine: false,
                                donutWidth: 12,
                                labelColor: Colors.transparent,
                              ),
                              Align(
                                  child: Text(
                                '$persentaseKelas11%',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800)),
                              )),
                            ],
                          ),
                        ),
                        Text('Sebelas (XI)',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800))),
                        Text(_jumlahKelas11.toString(),
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w800)))
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 16,
                          child: Stack(
                            children: [
                              DChartPie(
                                data: [
                                  {
                                    'domain': 'XII',
                                    'measure': _jumlahKelas11 + _jumlahKelas12
                                  },
                                  {'domain': 'X', 'measure': _jumlahKelas10},
                                ],
                                fillColor: (pieData, index) {
                                  switch (pieData['domain']) {
                                    case 'X':
                                      return Color(0xffDEBACE);

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
                                '$persentaseKelas10%',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800)),
                              )),
                            ],
                          ),
                        ),
                        Text('Sepuluh (X)',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800))),
                        Text(_jumlahKelas10.toString(),
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w800)))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 16,
                          child: Stack(
                            children: [
                              DChartPie(
                                data: [
                                  {
                                    'domain': 'XI',
                                    'measure': _jumlahKelas10 + _jumlahKelas11
                                  },
                                  {'domain': 'XII', 'measure': _jumlahKelas12},
                                ],
                                fillColor: (pieData, index) {
                                  switch (pieData['domain']) {
                                    case 'XII':
                                      return Color(0xffBA94D1);
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
                                '$persentaseKelas12%',
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800)),
                              )),
                            ],
                          ),
                        ),
                        Text('Dua Belas (XII)',
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800))),
                        Text(_jumlahKelas12.toString(),
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w800)))
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.only(
                  top: 15,
                  left: 30,
                  right: 30,
                ),
                width: double.infinity,
                height: 489,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: ListView(
                  children: [
                    Container(
                      child: const Steps(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 45,
        margin: EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahSiswaPage()));
          },
          child: Text("Tambah Data Siswa"),
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

List<String> kelasList10 = [];
List<String> kelasList11 = [];
List<String> kelasList12 = [];

Future<void> getKelasFromFirestore() async {
  QuerySnapshot<Map<String, dynamic>> snapshot10 = await FirebaseFirestore
      .instance
      .collection('kelas')
      .where('kelas', isEqualTo: 10)
      .get();

  QuerySnapshot<Map<String, dynamic>> snapshot11 = await FirebaseFirestore
      .instance
      .collection('kelas')
      .where('kelas', isEqualTo: 11)
      .get();

  QuerySnapshot<Map<String, dynamic>> snapshot12 = await FirebaseFirestore
      .instance
      .collection('kelas')
      .where('kelas', isEqualTo: 12)
      .get();

  kelasList10 =
      snapshot10.docs.map((doc) => doc.get('nama') as String).toList();
  kelasList11 =
      snapshot11.docs.map((doc) => doc.get('nama') as String).toList();
  kelasList12 =
      snapshot12.docs.map((doc) => doc.get('nama') as String).toList();
}

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);
  String title;
  List<String?> body;
  bool isExpanded;
}

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  final CollectionReference _siswa =
      FirebaseFirestore.instance.collection('siswa');

  List<Step> _steps = [];

  @override
  void initState() {
    super.initState();
    getKelasFromFirestore().then((_) {
      setState(() {
        _steps = [
          Step('Kelas Dua Belas (XII)', kelasList12),
          Step('Kelas Sebelas (XI)', kelasList11),
          Step('Kelas Sepuluh (X)', kelasList10),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _renderSteps(),
      ),
    );
  }

  Widget _renderSteps() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = !isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(15),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xff7F669D),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child:
                        Image(image: AssetImage('assets/images/document.png')),
                  ),
                  Text(step.title,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      )),
                ],
              ),
            );
          },
          body: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: step.body.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                  margin: EdgeInsets.only(bottom: 20),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          step.body[index].toString(),
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black45)),
                        ),
                        StreamBuilder(
                            stream: _siswa
                                .where('kelas', isEqualTo: step.body[index])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              return Text(snapshot.data!.docs.length.toString(),
                                  style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ));
                            })
                      ],
                    ),
                  ),
                );
              }),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}
