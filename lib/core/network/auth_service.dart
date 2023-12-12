import 'package:aplikasi_reservasi_dokter_candra_safitri/core/constants.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/core/dio_client.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/data/models/body/login_body.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/data/models/response/login_response.dart';
import 'package:dio/dio.dart';

class AuthService {
  static Future<LoginResponse> postLogin(LoginBody body) async {
    try {
      final result = await dioClient.post<Map<String, dynamic>>(
        '${Constants.baseUrl}/login',
        data: body.toJson(),
      );

      if (result.statusCode == 200) {
        if (result.data != null) {
          LoginResponse response = LoginResponse.fromJson(result.data!);
          return response;
        }
      }
      return LoginResponse(message: 'Unkown Error');
    } on DioException catch (e) {
      LoginResponse errorMessage =
          LoginResponse(message: e.response!.data['message'] as String);
      return errorMessage;
    } catch (e) {
      LoginResponse errorMessage =
          LoginResponse(message: 'Catch: ${e.toString()}');
      return errorMessage;
    }
  }
}
