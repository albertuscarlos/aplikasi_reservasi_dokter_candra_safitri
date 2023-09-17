class StreamDataReservasi {
  String id_reservasi;
  String kode_reservasi;
  String nama_pasien;
  String umur_pasien;
  String alamat;
  String tanggal_reservasi;
  String no_hp;
  String no_antrian;
  String status_reservasi;
  // String id_pasien;

  StreamDataReservasi.fromJson(Map<String, dynamic> json) 
  :   id_reservasi = json['id_reservasi'],
      kode_reservasi = json['kode_reservasi'],
      nama_pasien = json['nama_pasien'],
      tanggal_reservasi = json['tanggal_reservasi'],
      umur_pasien = json['umur_pasien'],
      alamat = json['alamat'],
      no_hp = json['no_hp'],
      no_antrian = json['no_antrian'],
      status_reservasi = json['status_reservasi'];
      // id_pasien: json['id_pasien'],
  
  Map<String, dynamic> toJson() => {
    'id_reservasi' : id_reservasi,
    'kode_reservasi' : kode_reservasi,
    'nama_pasien' : nama_pasien, 
    'tanggal_reservasi' : tanggal_reservasi,
    'umur_pasien' : umur_pasien,
    'alamat' : alamat,
    'no_hp' : no_hp,
    'no_antrian' : no_antrian,
    'status_reservasi' : status_reservasi
  };
}