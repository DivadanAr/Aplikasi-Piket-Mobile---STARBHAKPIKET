// ignore_for_file: deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/loading.json',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            TyperAnimatedTextKit(
              text: ['Starbhak Piket'],
              textStyle: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Color(0xffBA94D1),
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              speed: Duration(milliseconds: 140),
              isRepeatingAnimation: true,
            )
          ],
        ),
      ),
    );
  }
}
