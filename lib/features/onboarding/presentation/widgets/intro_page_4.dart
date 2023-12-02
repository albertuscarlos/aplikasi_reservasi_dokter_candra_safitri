import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage4 extends StatefulWidget {
  const IntroPage4({super.key});

  @override
  State<IntroPage4> createState() => _IntroPage4State();
}

class _IntroPage4State extends State<IntroPage4> {
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
                        'assets/images_onboarding/onboard_page4.png')),
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
                    height: 53,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cek Pengumuman Klinik",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff101623),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  SizedBox(
                    width: 311,
                    child: Text(
                      "Dapatkan semua informasi mengenai Klinik dr. Candra Safitri melalui aplikasi ini!",
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
