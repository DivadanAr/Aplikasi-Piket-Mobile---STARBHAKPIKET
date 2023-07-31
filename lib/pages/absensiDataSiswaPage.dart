// ignore_for_file: override_on_non_overriding_member, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:intl/intl.dart';
import 'package:starbhakpiket/models/absensiModel.dart';
import 'package:starbhakpiket/models/kelasModel.dart';
import 'package:starbhakpiket/pages/absensiDokumPage.dart';

class AbsensiDataSiswaPage extends StatefulWidget {
  final DocumentSnapshot data;

  const AbsensiDataSiswaPage({Key? key, required this.data}) : super(key: key);

  @override
  State<AbsensiDataSiswaPage> createState() => _AbsensiDataSiswaPageState();
}

class ListItem {
  String title;

  ListItem(this.title);
  @override
  String toString() {
    return '$title';
  }
}

class _AbsensiDataSiswaPageState extends State<AbsensiDataSiswaPage> {
  Future<List<String>> getSuggestions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('siswa')
        .where('kelas', isEqualTo: '${widget.data['nama']}')
        .get();
    return snapshot.docs.map((doc) => doc['nama'].toString()).toList();
  }

  final _searchController = TextEditingController();
  final List<String?> _listItems = [];

  List<String> _suggestions = [];
  List<String?> _selectedValue = [];
  List<String?> _namaIzin = [];
  List<String?> _namaSakit = [];
  List<String?> _namaAlfa = [];

  void _addItem() {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _listItems.add(_searchController.text);
        _searchController.clear();

        _selectedValue = List.generate(_listItems.length, (_) => null);
      });
    }
  }

  @override
  void _setSelectedValue(int index, String? value) {
    setState(() {
      _selectedValue[index] = value;
      if (value == 'izin') {
        _namaIzin.add(_listItems[index]);
      } else if (value == 'sakit') {
        _namaSakit.add(_listItems[index]);
      } else if (value == 'alfa') {
        _namaAlfa.add(_listItems[index]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSuggestions().then((suggestions) {
      setState(() {
        _suggestions = suggestions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    final DateTime now = DateTime.now();
    final String formattedDate = formatter.format(now);

    final DateFormat month = DateFormat('MMMM', 'id_ID');
    final DateTime monthNow = DateTime.now();
    final String monthDate = month.format(monthNow);

    final DateFormat day = DateFormat('EEEE', 'id_ID');
    final DateTime dayNow = DateTime.now();
    final String dayDate = day.format(dayNow);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(40, 50, 40, 25),
        child: Column(
          children: [
            // Text('izin : $_namaIzin'),
            // Text('izin : $_namaSakit'),
            // Text('izin : $_namaAlfa'),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
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
                                Text("${widget.data['nama']}",
                                    style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                    ))),
                                SizedBox(height: 3),
                                Text("${widget.data['guru']}",
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
                              child: Text(
                                  _suggestions.length.toString() + " siswa",
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
                        margin: EdgeInsets.only(top: 25, bottom: 20),
                        width: double.maxFinite,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border:
                                Border.all(width: 1, color: Colors.black26)),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          child: SearchField(
                            searchInputDecoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search_rounded,
                                size: 25,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
                                    width: 2, color: Colors.transparent),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                              ),
                            ),
                            suggestionState: Suggestion.expand,
                            suggestionAction: SuggestionAction.next,
                            suggestions: _suggestions
                                .map((e) => SearchFieldListItem(e))
                                .toList(),
                            textInputAction: TextInputAction.next,
                            controller: _searchController,
                            hint: 'Cari Data Siswa...',
                            maxSuggestionsInViewPort: 3,
                            itemHeight: 50,
                            onSuggestionTap: (x) {
                              _addItem();
                            },
                          ),
                        ),
                      ),
                      Text(_listItems.length.toString() + " siswa",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700))),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: _listItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Hapus Data'),
                                        content: const Text(
                                            'Apakah Anda yakin ingin menghapus data ini?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Batal'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Hapus'),
                                            onPressed: () {
                                              setState(() {
                                                _listItems.removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                width: double.maxFinite,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.black12)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      _listItems[index].toString(),
                                      style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: _selectedValue[index] ==
                                                  'izin'
                                              ? Color(0xffDEBACE)
                                              : _selectedValue[index] == 'alfa'
                                                  ? Color(0xffBA94D1)
                                                  : Color(0xff7F669D),
                                          // Color(0xff7F669D), // set the background color
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              String? _selectedValue;
                                              return AlertDialog(
                                                content: Container(
                                                  height: 210,
                                                  child: Column(
                                                    children: [
                                                      Text("KETERANGAN",
                                                          style: GoogleFonts.quicksand(
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800))),
                                                      SizedBox(height: 15),
                                                      RadioListTile(
                                                        title: Text('Izin'),
                                                        value: 'izin',
                                                        groupValue:
                                                            _selectedValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _setSelectedValue(
                                                                index, value);
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                      ),
                                                      RadioListTile(
                                                        title: Text('Sakit'),
                                                        value: 'sakit',
                                                        groupValue:
                                                            _selectedValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _setSelectedValue(
                                                                index, value);
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                      ),
                                                      RadioListTile(
                                                        title: Text('Alfa'),
                                                        value: 'alfa',
                                                        groupValue:
                                                            _selectedValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _setSelectedValue(
                                                                index, value);
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          _selectedValue[index] ?? 'Ket',
                                          style: TextStyle(
                                            color:
                                                _selectedValue[index] == 'izin'
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            ),
            Center(
              child: SizedBox(
                height: 45,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    print(_namaIzin);
                    print(_namaSakit);
                    print(_namaAlfa);
                    final absensi_add = absensi_model(
                      izin: _namaIzin,
                      sakit: _namaSakit,
                      alfa: _namaAlfa,
                      kelas: "${widget.data['nama']}",
                      tanggal: formattedDate,
                      bulan: monthDate,
                      hari: dayDate,
                    );
                    final getKelas = kelas_model(
                      nama: "${widget.data['nama']}",
                      guru: "${widget.data['guru']}",
                      jurusan: "${widget.data['jurusan']}",
                      sesi: int.tryParse("${widget.data['sesi']}") ?? 0,
                      jumlah: _suggestions.length,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AbsensiDokumPage(
                                absensi: absensi_add, datakelas: getKelas)));
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
