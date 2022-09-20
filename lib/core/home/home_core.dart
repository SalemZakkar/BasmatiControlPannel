import 'package:dio/dio.dart';

import '../../screens/authentication/persistance/storage.dart';
import '../../web_services/api_engine/api_engine.dart';
import '../../web_services/api_engine/enum.dart';
import '../../web_services/api_engine/response_model.dart';
import '../../web_services/web_services_export.dart';

class HomeCore{
  static Future<ResponseModel> getUserInfoByType(Map<String,String> sendData) async {
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
}