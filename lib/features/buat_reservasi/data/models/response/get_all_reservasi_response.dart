class AllReservasiData {
  final String idPasien;
  final String idReservasi;
  final String kodeReservasi;
  final String namaPasien;
  final String tanggalReservasi;
  final String umurPasien;
  final String alamat;
  final String noHp;
  final String noAntrian;

  AllReservasiData(
      {required this.idPasien,
      required this.idReservasi,
      required this.kodeReservasi,
      required this.namaPasien,
      required this.tanggalReservasi,
      required this.umurPasien,
      required this.alamat,
      required this.noHp,
      required this.noAntrian});

  factory AllReservasiData.fromModel(Map<String, dynamic> json) =>
      AllReservasiData(
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

class AllReservasiResponse {
  final List<AllReservasiData>? data;
  final bool status;
  final String? message;

  AllReservasiResponse({this.data, required this.status, this.message});

  factory AllReservasiResponse.fromJson(Map<String, dynamic> json) =>
      AllReservasiResponse(
          data: json["data"] != null
              ? List.from(
                  json["data"].map(
                    (listAntrian) => AllReservasiData.fromModel(listAntrian),
                  ),
                )
              : null,
          status: json["status"],
          message: json["message"]);
}
