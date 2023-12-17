class EditReservasiBody {
  EditReservasiBody({
    required this.namaPasien,
    required this.umurPasien,
    required this.alamat,
    required this.noHp,
    required this.tanggalReservasi,
  });
  final String namaPasien;
  final String umurPasien;
  final String alamat;
  final String noHp;
  final String tanggalReservasi;

  Map<String, dynamic> toJson() => {
        'nama_pasien': namaPasien,
        'umur_pasien': umurPasien,
        'alamat': alamat,
        'no_hp': noHp,
        'tanggal_reservasi': tanggalReservasi,
      };
}
