import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuatReservasiTopBar extends StatelessWidget {
  const BuatReservasiTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new,
              color: Color(0xff101623), size: 30),
        ),
        Center(
          child: Text(
            "Buat Reservasi",
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
