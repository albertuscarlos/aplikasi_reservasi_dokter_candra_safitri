import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
class Pasien{
  final _baseUrl = 'https://albertuscarlos-workspace.my.id/api';
  var baseURL = 'https://albertuscarlos-workspace.my.id/api';
  var dio = Dio();

  Future postData(
      String nama_lengkap,
      String jenis_kelamin,
      String tanggal_lahir,
      String no_telepon,
      String username,
      String password) async {
    try{
      final response = await http.post(Uri.parse(_baseUrl + '/pasien'),
          body: {
            "nama_lengkap" : nama_lengkap,
            "jenis_kelamin" : jenis_kelamin,
            "tanggal_lahir" : tanggal_lahir,
            "no_telepon" : no_telepon,
            "username" : username,
            "password" : password,
          }
      );
      if(response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print("Error di $e");
    }

  }
  //MAIN FUN
  Future<dynamic> postLogin(String username, String password) async {
    Map<String, dynamic> formData = {"username" : username, "password" : password
    };
    try{
      final response = await http.post(Uri.parse("$baseURL/login"), body: formData);
      var jsonParsed = await jsonDecode(response.body.toString());
      // var jsonParsed = await jsonDecode(json.encode(response.body.toString()));
      var dataPasien = jsonParsed['data'];

      print("Hasilnya --> ${dataPasien[0]['id_pasien']}");
      print("Hasilnya --> ${dataPasien[0]['nama_lengkap']}");
      // print("Hasilnya --> ${dataPasien[0]['username']}");
      // print("Hasilnya --> ${dataPasien[0]['password']}");
      // print(idPostLogin);
      if (response.statusCode == 200){
        // var idLoginPasien = dataPasien[0]['id_pasien'];
        // var usernamePasien = dataPasien[0]['username'];
        // var passwordPasien = dataPasien[0]['password'];
        // return dataPasien[0]['id_pasien'];
        return dataPasien;
        // final data = response.body;
        // return PasienModel(idPasien: "$idPostLogin");
      }else{
        print('gagal');
      }
    } catch (e) {
      print("Error di -> $e");
    }
  }

}
