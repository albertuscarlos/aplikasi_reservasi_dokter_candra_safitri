class ReservasiAndaData {
  final String idPasien;
  final String idReservasi;
  final String kodeReservasi;
  final String namaPasien;
  final String tanggalReservasi;
  final String umurPasien;
  final String alamat;
  final String noHp;
  final String noAntrian;

  ReservasiAndaData({
    required this.idPasien,
    required this.idReservasi,
    required this.kodeReservasi,
    required this.namaPasien,
    required this.tanggalReservasi,
    required this.umurPasien,
    required this.alamat,
    required this.noHp,
    required this.noAntrian,
  });

  factory ReservasiAndaData.fromModel(Map<String, dynamic> json) =>
      ReservasiAndaData(
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

class ReservasiAndaResponse {
  final List<ReservasiAndaData>? data;
  final bool? status;
  final String? message;

  ReservasiAndaResponse({this.data, this.message, this.status});

  factory ReservasiAndaResponse.fromJson(Map<String, dynamic> json) =>
      ReservasiAndaResponse(
        data: json["data"] != null
            ? List.from(json["data"].map(
                (listReservasi) => ReservasiAndaData.fromModel(listReservasi)))
            : null,
        status: json["status"],
        message: json["message"],
      );
}
