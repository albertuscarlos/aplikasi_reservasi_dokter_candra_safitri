import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservasiAndaListKosong extends StatelessWidget {
  const ReservasiAndaListKosong({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 70,
        ),
        SizedBox(
          width: 280,
          child: Image.asset('assets/oops.png'),
        ),
        Text("Anda Belum Melakukan Reservasi",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xff101623),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        Text(
            "Silahkan reservasi terlebih dahulu untuk mendapatkan nomor antrian",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              letterSpacing: 0.5,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color(0xff717784),
            )))
      ],
    );
  }
}
