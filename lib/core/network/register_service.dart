import 'package:aplikasi_reservasi_dokter_candra_safitri/core/constants.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/core/dio_client.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/data/body/signup_body.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/data/response/signup_response.dart';
import 'package:dio/dio.dart';

class RegisterService {
  static Future<SignUpResponse> postSignUpData(SignUpBody body) async {
    try {
      final result = await dioClient.post<Map<String, dynamic>>(
        '${Constants.baseUrl}/pasien',
        data: body.toJson(),
      );

      if (result.statusCode == 201) {
        if (result.data != null) {
          SignUpResponse response = SignUpResponse.fromJson(result.data!);
          return response;
        }
        return SignUpResponse(message: "Unknown Error");
      } else {
        SignUpResponse response = SignUpResponse.fromJson(result.data!);
        return response;
      }
    } on DioException catch (e) {
      SignUpResponse errorMessage =
          SignUpResponse(message: e.response!.data['message'] as String);
      return errorMessage;
    } catch (e) {
      SignUpResponse errorMessage =
          SignUpResponse(message: 'Catch: ${e.toString()}');
      return errorMessage;
    }
  }
}
