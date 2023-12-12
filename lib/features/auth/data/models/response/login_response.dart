class LoginData {
  final String idPasien;
  final String namaLengkap;
  final String jenisKelamin;
  final String tanggalLahir;
  final String noTelepon;
  final String fotoPasien;
  final String username;

  LoginData(
      {required this.idPasien,
      required this.namaLengkap,
      required this.jenisKelamin,
      required this.tanggalLahir,
      required this.noTelepon,
      required this.fotoPasien,
      required this.username});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
      idPasien: json["id_pasien"],
      namaLengkap: json["nama_lengkap"],
      jenisKelamin: json["jenis_kelamin"],
      tanggalLahir: json["tanggal_lahir"],
      noTelepon: json["no_telepon"],
      fotoPasien: json["foto_pasien"],
      username: json["username"]);
  Map<String, dynamic> toJson() => {
        "id_pasien": idPasien,
        "nama_lengkap": namaLengkap,
        "jenis_kelamin": jenisKelamin,
        "tanggal_lahir": tanggalLahir,
        "no_telepon": noTelepon,
        "foto_pasien": fotoPasien,
        "username": username,
      };
}

class LoginResponse {
  final LoginData? data;
  final String message;

  LoginResponse({
    this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        data: json["data"] != null ? LoginData.fromJson(json["data"]) : null,
        message: json["message"],
      );
  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
      };
}
