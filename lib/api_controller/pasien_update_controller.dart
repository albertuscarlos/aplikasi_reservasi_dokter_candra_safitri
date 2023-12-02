import 'package:http/http.dart' as http;

class UpdatePasien {
  final _url = 'https://reservasi.klinikdrcandrasafitri.com/api/pasien/';

  // Put Nama Pasien
  Future ubahNamaPasien(
    String nama_lengkap,
    String id_pasien,
  ) async {
    try {
      final response =
          await http.put(Uri.parse(_url + 'name/' + id_pasien), body: {
        "nama_lengkap": nama_lengkap,
        "id_pasien": id_pasien,
      });
      if (response.statusCode == 200) {
        print('true: $response');
        return true;
      } else {
        print('false: $response');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Put Jenis Kelamin
  Future ubahJenisKelaminPasien(
    String jenis_kelamin,
    String id_pasien,
  ) async {
    try {
      final response =
          await http.put(Uri.parse(_url + 'gender/' + id_pasien), body: {
        "jenis_kelamin": jenis_kelamin,
        "id_pasien": id_pasien,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Put Tanggal Lahir
  Future ubahTanggalLahirPasien(
    String tanggal_lahir,
    String id_pasien,
  ) async {
    try {
      final response =
          await http.put(Uri.parse(_url + 'birthdate/' + id_pasien), body: {
        "tanggal_lahir": tanggal_lahir,
        "id_pasien": id_pasien,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        print('error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Put Nomor Telepon
  Future ubahNomorTeleponPasien(
    String no_telepon,
    String id_pasien,
  ) async {
    try {
      final response =
          await http.put(Uri.parse(_url + 'phone/' + id_pasien), body: {
        "no_telepon": no_telepon,
        "id_pasien": id_pasien,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Put Nama Pasien
  Future ubahUsernamePasien(
    String username,
    String id_pasien,
  ) async {
    try {
      final response =
          await http.put(Uri.parse(_url + 'username/' + id_pasien), body: {
        "username": username,
        "id_pasien": id_pasien,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
