import 'package:dio/dio.dart';

import '../constants.dart';
import '../dio_client.dart';
import '../../features/auth/data/models/body/login_body.dart';
import '../../features/auth/data/models/response/login_response.dart';

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
