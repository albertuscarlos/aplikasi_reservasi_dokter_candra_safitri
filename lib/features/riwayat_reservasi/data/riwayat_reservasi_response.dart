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
        namaPasien: 'nama_pasien',
        umur: 'umur_pasien',
        alamat: 'alamat',
        tanggalReservasi: 'tanggal_reservasi',
        noAntrian: 'no_antrian',
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
