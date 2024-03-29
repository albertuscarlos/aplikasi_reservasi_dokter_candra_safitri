class DataRiwayatReservasi {
  String id_reservasi;
  String id_riwayat;
  String kode_reservasi;
  String nama_pasien;
  String umur_pasien;
  String alamat;
  String tanggal_reservasi;
  String no_hp;
  String no_antrian;
  // String id_pasien;

  DataRiwayatReservasi({
    required this.id_reservasi,
    required this.id_riwayat,
    required this.nama_pasien,
    required this.kode_reservasi,
    required this.tanggal_reservasi,
    required this.umur_pasien,
    required this.alamat,
    required this.no_hp,
    required this.no_antrian,
    // required this.id_pasien,
  });

  factory DataRiwayatReservasi.fromJson(Map<String, dynamic> json) {
    return DataRiwayatReservasi(
      id_reservasi: json['id_reservasi'],
      id_riwayat: json['id_riwayat'],
      kode_reservasi: json['kode_reservasi'],
      nama_pasien: json['nama_pasien'],
      tanggal_reservasi: json['tanggal_reservasi'],
      umur_pasien: json['umur_pasien'],
      alamat: json['alamat'],
      no_hp: json['no_hp'],
      no_antrian: json['no_antrian'],
      // id_pasien: json['id_pasien'],
    );
  }
}