import 'package:dio/dio.dart';

import '../../../web_services/endpoint.dart';
import '../../../web_services/web_connection.dart';
import '../persistance/storage.dart';

class AuthRepository {
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
