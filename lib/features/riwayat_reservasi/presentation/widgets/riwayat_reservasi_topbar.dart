import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiwayatReservasiTopBar extends StatelessWidget {
  const RiwayatReservasiTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            "Riwayat Reservasi",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff101623),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
