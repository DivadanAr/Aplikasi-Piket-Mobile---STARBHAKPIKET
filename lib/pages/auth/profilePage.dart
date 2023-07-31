import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CollectionReference _jadwal =
      FirebaseFirestore.instance.collection('jadwal piket');
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');

    final DateFormat day = DateFormat('EEEE', 'id_ID');
    final DateTime dayNow = DateTime.now();
    final String dayDate = day.format(dayNow);

    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                ClipPath(
                  clipper: ClipPathClass(),
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    color: Color(0xff7F669D),
                  ),
                ),
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 140, bottom: 40),
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                              Border.all(color: Color(0xff7F669D), width: 3)),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      )),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Guru Bertugas',
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54)),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(top: 12, left: 20),
                margin: EdgeInsets.only(bottom: 10),
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: StreamBuilder(
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
                            return Text(records['nama'],
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)));
                          });
                    }),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'jadwal',
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54)),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(top: 12, left: 20),
                margin: EdgeInsets.only(bottom: 10),
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: StreamBuilder(
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
                            return Text(records['jadwal mulai'] + ' - ' + records['jadwal akhir'],
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)));
                          });
                    }),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Akun',
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54)),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(top: 12, left: 20),
                margin: EdgeInsets.only(bottom: 10),
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text('${user.displayName}',
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54)),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.only(top: 12, left: 20),
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text('${user.email}',
                    style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))),
              )
            ],
          ),
          Container(
            width: 350,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_outlined),
                  SizedBox(width: 10),
                  Text("LogOut",
                      style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800))),
                ],
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff7F669D)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
