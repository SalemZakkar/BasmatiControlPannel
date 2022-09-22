import 'package:dio/dio.dart';

import '../../screens/authentication/persistance/storage.dart';
import '../../web_services/api_engine/api_engine.dart';
import '../../web_services/api_engine/enum.dart';
import '../../web_services/api_engine/response_model.dart';
import '../../web_services/web_services_export.dart';

class HomeCore {
  static Future<ResponseModel> getUserInfoByType(
      Map<String, String> sendData) async {
    ResponseModel res = await ApiEngine.request(
      requestMethod: RequestMethod.get,
      path: EndPoints.user,
      options: Options(
        headers: <String, String>{
          "Authorization": "Bearer ${await AuthStore.getToken()}",
        },
      ),
      queryParameters: sendData,
    );
    return res;
  }

  static Future<ResponseModel> getUser(
      int skip, int limit, String? phone, int type, int? sub) async {
    List<String> typeStr = ["Customer", "Admin"];
    Map<String, dynamic> query = {
      "skip": skip,
      "limit": limit,
      "type": typeStr[type],
      "total": true
    };
    if (phone != null && phone.isNotEmpty) {
      query["phone"] = phone;
    }
    if (sub != null) {
      //TODO SUB TYPE
    }
    ResponseModel res = await ApiEngine.request(
      requestMethod: RequestMethod.get,
      path: EndPoints.user,
      options: Options(
        headers: <String, String>{
          "Authorization": "Bearer ${await AuthStore.getToken()}",
        },
      ),
      queryParameters: query,
    );
    return res;
  }
}
