import 'dart:convert';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/riwayat_reservasi_model.dart';
import 'package:http/http.dart' as http;

class Riwayat {
  final _baseUrl = 'https://klinikdrcandrasafitri.com/api/';

  // //Get Riwayat Reservasi By Id
  // Future<List<DataReservasi>> getRiwayatReservasiById($idPasien) async {
  //   final response = await http.get(Uri.parse(_baseUrl+'/riwayat/?id_pasien='+$idPasien));
  //   var jsonParsed = jsonDecode(response.body);
  //   var dataReservasi = jsonParsed['data'];

  //   if (response.statusCode == 200){
  //     List jsonResponse = dataReservasi;
  //     return jsonResponse.map((data) => DataReservasi.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Failed to load Data');
  //   }
  // }

  Future<List<DataRiwayatReservasi>> getRiwayatReservasiById($idPasien) async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl + '/riwayat/?id_pasien=' + $idPasien));
      var jsonParsed = jsonDecode(response.body);
      var dataRiwayat = jsonParsed['data'];

      if (response.statusCode == 200) {
        List jsonResponse = dataRiwayat;
        return jsonResponse
            .map((data) => DataRiwayatReservasi.fromJson(data))
            .toList();
      } else {
        // Return a custom error response instead of throwing an exception
        return Future.error('Failed to load Data');
      }
    } catch (e) {
      // Handle other exceptions here, e.g., network errors
      print('Exception: $e');
      return Future.error('Failed to load Data - Exception: $e');
    }
  }
}
