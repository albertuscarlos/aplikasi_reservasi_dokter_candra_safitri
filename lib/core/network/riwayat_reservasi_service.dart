import '../../features/riwayat_reservasi/data/riwayat_reservasi_response.dart';
import '../constants.dart';
import '../dio_client.dart';

class RiwayatReservasiService {
  static Future<RiwayatReservasiResponse> getRiwayatReservasi(
      String idPasien) async {
    final request = await dioClient
        .get('${Constants.baseUrl}/riwayat/?id_pasien=$idPasien');

    if (request.statusCode == 200) {
      RiwayatReservasiResponse response =
          RiwayatReservasiResponse.fromJson(request.data);
      return response;
    } else {
      RiwayatReservasiResponse response =
          RiwayatReservasiResponse(message: 'Failed To Get Riwayat Reservasi');
      return response;
    }
  }
}
