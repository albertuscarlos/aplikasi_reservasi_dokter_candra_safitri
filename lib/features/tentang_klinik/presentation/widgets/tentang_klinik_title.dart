import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TentangKlinikTitle extends StatelessWidget {
  const TentangKlinikTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Apa itu Klinik dr. Candra Safitri?",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Color(0xff101623),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
