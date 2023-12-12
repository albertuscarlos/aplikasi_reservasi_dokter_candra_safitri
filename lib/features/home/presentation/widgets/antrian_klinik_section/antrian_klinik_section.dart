import 'dart:async';
import 'package:aplikasi_reservasi_dokter_candra_safitri/core/network/home_service.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/data/models/response/get_antrian_klinik_response.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/antrian_klinik_section/antrian_klinik_available.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/antrian_klinik_section/antrian_klinik_kosong.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AntrianKlinikSection extends StatelessWidget {
  const AntrianKlinikSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<AntrianKlinikData>(
                stream: AntrianKlinikService.antrianlinik(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Kasus: Sedang memuat data
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Kasus: Terjadi kesalahan
                    return AntrianKlinikKosong(
                        antrianKosong: "Belum ada antrian klinik",
                        noAntrian: 'A-000',
                        statusReservasi: "Belum ada pemeriksaan",
                        tanggalHariIni: DateFormat('MMMM dd, yyyy - hh:mm a')
                            .format(DateTime.now()));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    // Kasus: Tidak ada data atau data null
                    return const Text('Tidak ada data.');
                  } else {
                    // Kasus: Data sudah tersedia
                    return AntrianKlinikAvailable(
                        dataReservasi: snapshot.data!,
                        statusReservasi: "Proses Pemeriksaan");
                  }
                }),
          ),
        ],
      ),
    );
  }
}
