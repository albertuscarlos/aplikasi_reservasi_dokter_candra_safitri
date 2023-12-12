import 'dart:developer';

import 'package:aplikasi_reservasi_dokter_candra_safitri/core/constants.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/core/dio_client.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/data/models/response/get_pengumuman_response.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/data/models/response/get_antrian_klinik_response.dart';

class PengumumanService {
  static Future<PengumumanResponse> getPengumuman() async {
    final response = await dioClient.get('${Constants.secondUrl}/pengumuman');
    return PengumumanResponse.fromJson(response.data);
  }
}

class AntrianKlinikService {
  static Future<AntrianKlinikResponse> getAntrianKlinik() async {
    final response = await dioClient.get('${Constants.secondUrl}/reservasi');
    if (response.statusCode == 200) {
      return AntrianKlinikResponse.fromJson(response.data);
    } else {
      return AntrianKlinikResponse.fromJson(response.data);
    }
  }

  static Future<AntrianKlinikData> getAllReservasi() async {
    log("SET STATE");
    final response = await AntrianKlinikService.getAntrianKlinik();

    if (response.status == true) {
      final listAntrianKlinik = response.data!;
      for (var i = 0; i < listAntrianKlinik.length; i++) {
        var data = listAntrianKlinik[i];
        if (i == 0) {
          return data;
        }
      }
    } else {
      throw Exception('Failed to load Data');
    }
    return getAllReservasi();
  }

  static Stream<AntrianKlinikData> antrianlinik() {
    final stream = Stream.periodic(const Duration(seconds: 3))
        .asyncMap((_) => getAllReservasi());
    return stream;
  }
}
