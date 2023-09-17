import 'package:aplikasi_reservasi_dokter_candra_safitri/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilDokter extends StatefulWidget {
  final String idPasien;
  const ProfilDokter({super.key, required this.idPasien});

  @override
  State<ProfilDokter> createState() => _ProfilDokterState();
}

class _ProfilDokterState extends State<ProfilDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Stack(
							children: [
								GestureDetector(
                  onTap: () {
                    Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage(idPasien: widget.idPasien)));
                  },
                  child: Icon(
									Icons.arrow_back_ios_new,
									color: Color(0xff101623),
									size: 30),
                ),
						
								Center(
									child: Text("Profil Dokter",
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
						),
            SizedBox(
              height: 53,
            ),
            SizedBox(
              width: 293,
              height: 293,
              child: Image.asset('assets/doctor_profile.png')),
            SizedBox(
              height: 37,
            ),
            Row(
              children: [
                Text("Tentang",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color(0xff101623),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,                              
                      ),
                    ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                    width: 343,
                    child: Text("Dokter Candra Safitri merupakan Dokter sekaligus pemilik dari Klinik dr. Candra Safitri",
                    textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff717784),
                      ),
                      ),
                    ),
                  ),
              ],
            ),
            ],
          ),
        )),
    );
  }
}