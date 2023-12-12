class PostReservasiBody {
  final String idPasien;
  final String namaPasien;
  final String umurPasien;
  final String tanggalReservasi;
  final String alamatPasien;
  final String noHp;

  PostReservasiBody(
      {required this.idPasien,
      required this.namaPasien,
      required this.umurPasien,
      required this.tanggalReservasi,
      required this.alamatPasien,
      required this.noHp});

  Map<String, dynamic> toJson() => {
        "id_pasien": idPasien,
        "nama_pasien": namaPasien,
        "umur_pasien": umurPasien,
        "tanggal_reservasi": tanggalReservasi,
        "alamat": alamatPasien,
        "no_hp": noHp,
      };
}
