import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          height: 100,
          color: Color.fromARGB(255, 254, 254, 254),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                  ),
                ),
                Container(
                  width: 170,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      "Lupa Kata Sandi",
                      style: GoogleFonts.quicksand(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
              color: Color(0xff7F669D),
              borderRadius: BorderRadius.circular(200),
              image: DecorationImage(image: AssetImage("assets/images/pass.png"))),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 240, top: 25),
          child: Align(
            child: Text(
              "Email Anda",
              style: GoogleFonts.quicksand(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
          child: Container(
            width: 420,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: Text(
                "Masukkan Email untuk mengirim password",
                style: GoogleFonts.quicksand(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 240, top: 25),
          child: Align(
            child: Text(
              "Email admin",
              style: GoogleFonts.quicksand(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
          child: Container(
            width: 420,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: Text(
                "Konfirmasi Password Baru Anda...",
                style: GoogleFonts.quicksand(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
          child: Center(
            child: Container(
              width: 425,
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0xff7F669D),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 5)),
                  Text(
                    "Cancel",
                    style: GoogleFonts.quicksand(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Save",
                    style: GoogleFonts.quicksand(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
