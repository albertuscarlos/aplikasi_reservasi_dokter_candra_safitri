import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/network/home_service.dart';
import '../../../data/models/response/get_antrian_klinik_response.dart';
import 'antrian_klinik_available.dart';
import 'antrian_klinik_kosong.dart';

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
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return AntrianKlinikKosong(
                    antrianKosong: "Belum ada antrian klinik",
                    noAntrian: 'A-000',
                    statusReservasi: "Belum ada pemeriksaan",
                    tanggalHariIni:
                        DateFormat('MMMM dd, yyyy - hh:mm a').format(
                      DateTime.now(),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Text('Tidak ada data.');
                } else {
                  return AntrianKlinikAvailable(
                      dataReservasi: snapshot.data!,
                      statusReservasi: "Proses Pemeriksaan");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
