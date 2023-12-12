class SignUpBody {
  final String namaLengkap;
  final String jenisKelamin;
  final String tanggalLahir;
  final String noTelepon;
  final String username;
  final String password;

  SignUpBody({
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.noTelepon,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "nama_lengkap": namaLengkap,
        "jenis_kelamin": jenisKelamin,
        "tanggal_lahir": tanggalLahir,
        "no_telepon": noTelepon,
        "username": username,
        "password": password,
      };
}
