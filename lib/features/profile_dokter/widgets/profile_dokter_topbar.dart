import 'package:aplikasi_reservasi_dokter_candra_safitri/features/navbar/presentation/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilDokterTopBar extends StatelessWidget {
  const ProfilDokterTopBar({super.key, required this.idPasien});

  final String idPasien;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => NavBar(idPasien: idPasien)));
          },
          child: const Icon(Icons.arrow_back_ios_new,
              color: Color(0xff101623), size: 30),
        ),
        Center(
          child: Text(
            "Profil Dokter",
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
