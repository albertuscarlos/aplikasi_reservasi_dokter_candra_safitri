import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AntrianKlinikAvailable extends StatelessWidget {
  const AntrianKlinikAvailable(
      {super.key, required this.dataReservasi, required this.statusReservasi});

  final DataReservasi dataReservasi;
  final String statusReservasi;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff199A8E),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 13,
          ),
          Container(
            height: 84,
            width: 84,
            decoration: BoxDecoration(
                color: const Color(0xff51C9BE),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text(
                dataReservasi.no_antrian,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffF6F6F6),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          Container(
            margin: const EdgeInsets.only(top: 23, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataReservasi.tanggal_reservasi,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  dataReservasi.nama_pasien,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffF6F6F6),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      color: Color(0xfff0ad4e),
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      statusReservasi,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color(0xfff0ad4e),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
