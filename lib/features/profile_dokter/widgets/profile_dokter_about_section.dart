import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDokterAboutSection extends StatelessWidget {
  const ProfileDokterAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 343,
          child: Text(
            "Dokter Candra Safitri merupakan Dokter sekaligus pemilik dari Klinik dr. Candra Safitri",
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
