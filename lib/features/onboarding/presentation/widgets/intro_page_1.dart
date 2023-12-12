import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              children: [
                const SizedBox(
                  height: 103,
                ),
                SizedBox(
                    width: 265,
                    child: Image.asset(
                        'assets/images_onboarding/onboard_page1.png')),
              ],
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 400,
                  ),
                  SizedBox(
                    width: 311,
                    child: Text(
                      "Selamat Datang di Aplikasi Klinik dr. Candra Safitri",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff101623),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  SizedBox(
                    width: 311,
                    child: Text(
                      "Berobat semakin mudah dengan Aplikasi Klinik dr. Candra Safitri!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
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
