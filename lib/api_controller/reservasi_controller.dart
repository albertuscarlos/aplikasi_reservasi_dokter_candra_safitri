import 'dart:convert';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:http/http.dart' as http;

class Reservasi{
  final _baseUrl = 'https://albertuscarlos-workspace.my.id/api/';
  final _newUrl = 'https://reservasi.albertuscarlos-workspace.my.id/api/reservasi/';

  //Create Data Reservasi
  Future postData(
      String nama_pasien,
      String umur_pasien,
      String tanggal_reservasi,
      String alamat,
      String no_hp,
      String idPasien,
      ) async {
    try{
      final response = await http.post(Uri.parse(_baseUrl + '/reservasi'),
      body: {
        "nama_pasien" : nama_pasien,
        "umur_pasien" : umur_pasien,
        "tanggal_reservasi" : tanggal_reservasi,
        "alamat" : alamat,
        "no_hp" : no_hp,
        "id_pasien": idPasien,
      }
      );
      if(response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      print(e.toString());
    }
  }

    //Get Data Reservasi By Id
  // Future<List<DataReservasi>> getReservasiDataById($idPasien) async {
  //   final response = await http.get(Uri.parse(_baseUrl+'/reservasi/?id_pasien='+$idPasien));
  //   var jsonParsed = jsonDecode(response.body);
  //   var dataReservasi = jsonParsed['data'];

  //   if (response.statusCode == 200){
  //     List jsonResponse = dataReservasi;
  //     return jsonResponse.map((data) => DataReservasi.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Failed to load Data');
  //   }
  // }

  Future<List<DataReservasi>> getReservasiDataById($idPasien) async {
  try {
    final response = await http.get(Uri.parse(_baseUrl+'/reservasi/?id_pasien='+$idPasien));
    var jsonParsed = jsonDecode(response.body);
    var dataReservasi = jsonParsed['data'];

    if (response.statusCode == 200){
      List jsonResponse = dataReservasi;
      return jsonResponse.map((data) => DataReservasi.fromJson(data)).toList();
    } else {
      // Return a custom error response instead of throwing an exception
      return Future.error('Failed to load Data');
    }
  } catch (e) {
    // Handle other exceptions here, e.g., network errors
    print('Exception: $e');
    return Future.error('Failed to load Data');
  }
}
  
  // Get All Data Reservasi
  Future<List<DataReservasi>> getAllReservasiData() async {
    final response = await http.get(Uri.parse(_newUrl));
    var jsonParsed = jsonDecode(response.body);
    var allDataReservasi = jsonParsed['data'];

    if (response.statusCode == 200){
      List jsonResponse = allDataReservasi;
      return jsonResponse.map((data) => DataReservasi.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load Data');
    }
  }

  // Delete Data Reservasi
  Future deleteReservasi(String id_reservasi) async {
    final response = await http.delete(Uri.parse(_newUrl+ 'delete/' + id_reservasi));
    // print("Hasilnya --> ${dataReservasi[0]['id_reservasi']}");
    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Put Data Reservasi
  Future ubahData(
      String id_reservasi,
      String nama_pasien,
      String umur_pasien,
      String tanggal_reservasi,
      String alamat,
      String no_hp,
      String id_pasien,
      ) async {
    try{
      final response = await http.put(Uri.parse(_newUrl + 'update/' + id_reservasi),
          body: {
            "nama_pasien" : nama_pasien,
            "umur_pasien" : umur_pasien,
            "tanggal_reservasi" : tanggal_reservasi,
            "alamat" : alamat,
            "no_hp" : no_hp,
            "id_pasien": id_pasien,});
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