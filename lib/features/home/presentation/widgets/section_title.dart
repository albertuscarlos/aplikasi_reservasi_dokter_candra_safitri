import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.sectionTitle});
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          sectionTitle,
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
