import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
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
                child: Image.asset('assets/images_onboarding/onboard_page3.png')
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
                height: 53,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Cek Antrian Klinik",
                    textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff101623),
                      ),
                      ),
                    ),
                  ],
                ),
                        ),
              SizedBox(
                height: 17,
              ),
              SizedBox(
                width: 311,
                child: Text("Cek antrian yang sedang berlangsung pada Klinik dr. Candra Safitri pada menu antrian klinik",
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