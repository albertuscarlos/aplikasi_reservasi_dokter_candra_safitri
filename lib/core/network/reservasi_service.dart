import 'package:dio/dio.dart';

import '../../features/buat_reservasi/data/models/body/post_reservasi_body.dart';
import '../../features/buat_reservasi/data/models/response/get_all_reservasi_response.dart';
import '../../features/buat_reservasi/data/models/response/get_reservasi_by_id.dart';
import '../../features/buat_reservasi/data/models/response/post_reservasi_response.dart';
import '../../features/edit_reservasi/data/body/edit_reservasi_body.dart';
import '../../features/edit_reservasi/data/response/edit_reservasi_response.dart';
import '../../features/reservasi_anda/data/response/delete_reservasi_response.dart';
import '../../features/reservasi_anda/data/response/reservasi_anda_response.dart';
import '../constants.dart';
import '../dio_client.dart';

class ReservasiService {
  //Antrian Klinik Page
  static Future<AllReservasiResponse> getAllReservasi() async {
    final response = await dioClient.get('${Constants.secondUrl}/reservasi');
    if (response.statusCode == 200) {
      return AllReservasiResponse.fromJson(response.data);
    } else {
      return AllReservasiResponse.fromJson(response.data);
    }
  }

  //For Buat Reservasi Page
  static Future<ReservasiResponse> getReservasiById(String idPasien) async {
    final response = await dioClient
        .get('${Constants.baseUrl}/reservasi/?id_pasien=$idPasien');
    if (response.statusCode == 200) {
      return ReservasiResponse.fromJson(response.data);
    } else {
      return ReservasiResponse.fromJson(response.data);
    }
  }

  //Reservasi Anda Page
  static Future<ReservasiAndaResponse> getReservasiAnda(String idPasien) async {
    final response = await dioClient
        .get('${Constants.baseUrl}/reservasi/?id_pasien=$idPasien');
    if (response.statusCode == 200) {
      return ReservasiAndaResponse.fromJson(response.data);
    } else {
      return ReservasiAndaResponse.fromJson(response.data);
    }
  }

  static Future<DeleteReservasiResponse> deleteReservasi(
      String idPasien) async {
    try {
      final result = await dioClient
          .delete('${Constants.secondUrl}/reservasi/delete/$idPasien');

      if (result.statusCode! < 500) {
        DeleteReservasiResponse response =
            DeleteReservasiResponse.fromJson(result.data!);
        return response;
      } else {
        DeleteReservasiResponse response =
            DeleteReservasiResponse.fromJson(result.data);
        return response;
      }
    } catch (e) {
      DeleteReservasiResponse response =
          DeleteReservasiResponse(status: false, message: e.toString());
      return response;
    }
  }

  static Future<EditReservasiResponse> editReservasi(
      EditReservasiBody body, String idPasien) async {
    try {
      final request = await dioClient.put(
        '${Constants.secondUrl}/reservasi/update/$idPasien',
        data: body.toJson(),
      );

      if (request.statusCode! < 500) {
        EditReservasiResponse response =
            EditReservasiResponse.fromJson(request.data);
        return response;
      } else {
        EditReservasiResponse response =
            EditReservasiResponse.fromJson(request.data);
        return response;
      }
    } catch (e) {
      EditReservasiResponse response =
          EditReservasiResponse(message: e.toString());
      return response;
    }
  }

  //Buat Reservasi Page
  static Future<PostReservasiResponse> postReservasi(
      PostReservasiBody body) async {
    try {
      final result = await dioClient.post(
        '${Constants.baseUrl}/reservasi',
        data: body.toJson(),
      );
      if (result.statusCode! < 500) {
        PostReservasiResponse response =
            PostReservasiResponse.fromJson(result.data);
        return response;
      } else {
        return PostReservasiResponse(message: "uNKNOWN ERROR", status: false);
      }
    } on DioException catch (e) {
      return PostReservasiResponse(
          status: false, message: 'DioException: ${e.message.toString()}');
    } catch (e) {
      return PostReservasiResponse(
          status: false, message: 'Catch: ${e.toString()}');
    }
  }
}
