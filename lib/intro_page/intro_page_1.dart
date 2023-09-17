import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Column(
            children: [
              SizedBox(
                height: 103,
              ),
              SizedBox(
                width: 265,
                child: Image.asset('assets/images_onboarding/onboard_page1.png')
              ),
            ],
          )
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 400,
                ),
                SizedBox(
                width: 311,
                child: Text("Selamat Datang di Aplikasi Klinik dr. Candra Safitri",
                textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff101623),
                  ),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              SizedBox(
                width: 311,
                child: Text("Berobat semakin mudah dengan Aplikasi Klinik dr. Candra Safitri!",
                textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff717784),
                  ),
                  ),
                ),
              ),
              ],
            )
          ],
        )
        ],
      ),
    );
  }
}