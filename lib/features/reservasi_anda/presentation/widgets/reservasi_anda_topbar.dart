import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservasiAndaTopBar extends StatelessWidget {
  const ReservasiAndaTopBar({super.key});

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
            "Reservasi Anda",
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
