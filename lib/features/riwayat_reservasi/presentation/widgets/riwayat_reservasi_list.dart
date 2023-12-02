import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiwayatReservasiList extends StatelessWidget {
  const RiwayatReservasiList(
      {super.key,
      required this.nama,
      required this.umur,
      required this.alamat,
      required this.tanggal,
      required this.antrian,
      required this.status});

  final String nama;
  final String umur;
  final String alamat;
  final String tanggal;
  final String status;
  final String antrian;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffffffff),
      ),
      child: Column(
        children: [
          Container(
              height: 90,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xfff6f6f6)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$nama, $umur",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff101623),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(alamat,
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff717784),
                      ))),
                ],
              )),
          Container(
            height: 70,
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Color(0xfff6f6f6)),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160,
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      border:
                          Border(right: BorderSide(color: Color(0xfff6f6f6)))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tanggal Reservasi",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff101623),
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(tanggal,
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            letterSpacing: 0.5,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff717784),
                          ))),
                    ],
                  ),
                ),
                Container(
                  width: 182,
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status Reservasi",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff101623),
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.verified_outlined,
                            color: Color(0xff5cb85c),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            status,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff5cb85c),
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
          ),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text("Antrian Anda",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff101623),
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Text(antrian,
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff101623),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
