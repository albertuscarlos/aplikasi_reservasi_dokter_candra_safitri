class RiwayatReservasiData {
  RiwayatReservasiData({
    required this.namaPasien,
    required this.umur,
    required this.alamat,
    required this.tanggalReservasi,
    required this.noAntrian,
  });

  factory RiwayatReservasiData.fromModel(Map<String, dynamic> json) =>
      RiwayatReservasiData(
        namaPasien: json['nama_pasien'],
        umur: json['umur_pasien'],
        alamat: json['alamat'],
        tanggalReservasi: json['tanggal_reservasi'],
        noAntrian: json['no_antrian'],
      );

  final String namaPasien;
  final String umur;
  final String alamat;
  final String tanggalReservasi;
  final String noAntrian;
}

class RiwayatReservasiResponse {
  RiwayatReservasiResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RiwayatReservasiResponse.fromJson(Map<String, dynamic> json) =>
      RiwayatReservasiResponse(
        status: json['status'],
        data: json['data'] != null
            ? List.from(
                json['data'].map(
                  (riwayat) => RiwayatReservasiData.fromModel(riwayat),
                ),
              )
            : null,
      );

  final bool? status;
  final String? message;
  final List<RiwayatReservasiData>? data;
}
