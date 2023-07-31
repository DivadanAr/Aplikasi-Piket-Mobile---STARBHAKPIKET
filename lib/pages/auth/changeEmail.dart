import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
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
                  width: 150,
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
                      child: Text("Ubah Email",
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
            padding: EdgeInsets.all(50),
            margin: EdgeInsets.only(top: 40, bottom: 30),
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff7F669D),
            ),
            child: Image(
              image: NetworkImage(
                  '${user.photoURL}'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email Lama',
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
                child: Text('${user.email}',
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
                'Email Baru',
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
              ),
            ],
          ),
          Container(
            width: 350,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Verifikasi",
                  style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800))),
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
