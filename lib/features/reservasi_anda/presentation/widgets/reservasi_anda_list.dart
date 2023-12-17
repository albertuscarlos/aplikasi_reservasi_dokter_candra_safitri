import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../edit_reservasi/presentation/pages/edit_reservasi.dart';
import '../bloc/delete_reservasi/delete_reservasi_bloc.dart';

class ListReservasi extends StatelessWidget {
  const ListReservasi({
    super.key,
    required this.idPasien,
    required this.nama,
    required this.umur,
    required this.alamat,
    required this.antrian,
    required this.delete,
    required this.reservasiId,
    required this.status,
    required this.tanggal,
    required this.deleteReservasiBloc,
    required this.noHp,
  });

  final String idPasien;
  final String umur;
  final String nama;
  final String alamat;
  final String noHp;
  final String tanggal;
  final String status;
  final String antrian;
  final String delete;
  final String reservasiId;
  final DeleteReservasiBloc deleteReservasiBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
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
                border: Border(bottom: BorderSide(color: Color(0xfff6f6f6)))),
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
                            Icons.timer_outlined,
                            color: Color(0xfff0ad4e),
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
          ),
          Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xfff6f6f6)))),
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
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 172,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      border:
                          Border(right: BorderSide(color: Color(0xfff6f6f6)))),
                  child: GestureDetector(
                    onTap: () {
                      deleteReservasiBloc.add(
                        DeleteReservasi(idReservasi: reservasiId),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.delete_outlined,
                            color: Color(0xffd9534f)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("Batalkan Reservasi",
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 13,
                                color: Color(0xffd9534f),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 172,
                  height: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditReservasi(
                            idReservasi: reservasiId,
                            namaLengkap: nama,
                            umur: umur,
                            alamat: alamat,
                            noHp: noHp,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit, color: Color(0xfff0ad4e)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("Edit Reservasi",
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 13,
                                color: Color(0xfff0ad4e),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
