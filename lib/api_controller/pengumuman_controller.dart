import 'dart:convert';
import 'package:http/http.dart' as http;

class Pengumuman {
  final _pengumumanUrl =
      'https://reservasi.klinikdrcandrasafitri.com/api/pengumuman/';

// Get All Data Pengumuman
  Future<List<DataPengumuman>> getPengumumanData() async {
    try {
      final response = await http.get(Uri.parse(_pengumumanUrl));
      var jsonParsed = jsonDecode(response.body);
      var pengumuman = jsonParsed['data'];

      if (response.statusCode == 200) {
        List jsonResponse = pengumuman;
        return jsonResponse
            .map((data) => DataPengumuman.fromJson(data))
            .toList();
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
}

class DataPengumuman {
  String id;
  String pengumuman;
  // String id_pasien;

  DataPengumuman({
    required this.id,
    required this.pengumuman,
  });

  factory DataPengumuman.fromJson(Map<String, dynamic> json) {
    return DataPengumuman(
      id: json['id'],
      pengumuman: json['pengumuman'],
      // id_pasien: json['id_pasien'],
    );
  }
}
