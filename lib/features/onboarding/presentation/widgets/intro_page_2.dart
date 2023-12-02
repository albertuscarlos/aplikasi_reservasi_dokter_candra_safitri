import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
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
                        'assets/images_onboarding/onboard_page2.png')),
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
                      "Reservasi ke Klinik dr. Candra Safitri",
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
                      "Reservasi kini semakin mudah, cukup melalui smartphone anda maka anda akan mendapatkan nomor antrian untuk berobat pada Klinik dr. Candra Safitri",
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
