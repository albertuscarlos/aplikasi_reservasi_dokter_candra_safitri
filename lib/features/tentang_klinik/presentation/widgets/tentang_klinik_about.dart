import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TentangKlinikAbout extends StatelessWidget {
  const TentangKlinikAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 343,
          child: Text(
            "Klinik dr. Candra Safitri merupakan salah satu klinik yang berlokasi di Triharjo, Wates, Kulon Progo.",
            textAlign: TextAlign.justify,
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
    );
  }
}
