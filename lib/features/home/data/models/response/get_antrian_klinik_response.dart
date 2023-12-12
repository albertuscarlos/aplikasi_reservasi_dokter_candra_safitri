import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/data/models/response/get_pengumuman_response.dart';

class AntrianKlinikData {
  final String idPasien;
  final String idReservasi;
  final String kodeReservasi;
  final String namaPasien;
  final String tanggalReservasi;
  final String umurPasien;
  final String alamat;
  final String noHp;
  final String noAntrian;

  AntrianKlinikData(
      {required this.idPasien,
      required this.idReservasi,
      required this.kodeReservasi,
      required this.namaPasien,
      required this.tanggalReservasi,
      required this.umurPasien,
      required this.alamat,
      required this.noHp,
      required this.noAntrian});

  factory AntrianKlinikData.fromModel(Map<String, dynamic> json) =>
      AntrianKlinikData(
        idPasien: json["id_pasien"],
        idReservasi: json["id_reservasi"],
        kodeReservasi: json["kode_reservasi"],
        namaPasien: json["nama_pasien"],
        tanggalReservasi: json["tanggal_reservasi"],
        umurPasien: json["umur_pasien"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        noAntrian: json["no_antrian"],
      );

  factory AntrianKlinikData.fromJson(Map<String, dynamic> json) =>
      AntrianKlinikData(
        idPasien: json["id_pasien"],
        idReservasi: json["id_reservasi"],
        kodeReservasi: json["kode_reservasi"],
        namaPasien: json["nama_pasien"],
        tanggalReservasi: json["tanggal_reservasi"],
        umurPasien: json["umur_pasien"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        noAntrian: json["no_antrian"],
      );
}

class AntrianKlinikResponse {
  final List<AntrianKlinikData>? data;
  final bool status;
  final String? message;

  AntrianKlinikResponse({this.data, required this.status, this.message});

  factory AntrianKlinikResponse.fromJson(Map<String, dynamic> json) =>
      AntrianKlinikResponse(
          data: json["data"] != null
              ? List.from(
                  json["data"].map(
                    (listAntrian) => AntrianKlinikData.fromModel(listAntrian),
                  ),
                )
              : null,
          status: json["status"],
          message: json["message"]);
}
