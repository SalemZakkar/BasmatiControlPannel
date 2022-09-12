import 'package:dio/dio.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/web_services/endpoint.dart';
import 'package:web_basmati/web_services/web_connection.dart';

class AuthCore {
  static Future<Response> login(String phone, String password) async {
    Response res = await myDio
        .post(EndPoints.signIn, data: {"phone": phone, "password": password},
            options: Options(validateStatus: (code) {
      return (code ?? 1000) < 500;
    }));
    return res;
  }

  static Future<Response?> refreshToken() async {
    String? refreshToken = await AuthStore.getRefresh();
    if (refreshToken == null) {
      return null;
    }
    Response res = await myDio.post(EndPoints.refreshToken,
        data: {"token": refreshToken}, options: Options(validateStatus: (code) {
      return (code ?? 1000) < 500;
    }));
    return res;
  }

  static void logout() async {
    await AuthStore.clear();
  }
}
