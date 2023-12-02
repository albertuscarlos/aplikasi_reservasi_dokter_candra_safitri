import 'dart:async';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/antrian_klinik_section/antrian_klinik_available.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/antrian_klinik_section/antrian_klinik_kosong.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AntrianKlinikSection extends StatelessWidget {
  const AntrianKlinikSection({super.key, required this.streamController});

  final StreamController<DataReservasi> streamController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<DataReservasi>(
                stream: streamController.stream,
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
