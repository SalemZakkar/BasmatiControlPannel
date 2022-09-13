import 'package:dio/dio.dart';
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


}
