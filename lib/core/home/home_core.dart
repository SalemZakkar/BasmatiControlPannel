import 'package:dio/dio.dart';
import 'package:web_basmati/screens/home/model/user_model.dart';

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

  static Future<ResponseModel> getUserData(String id) async {
    ResponseModel res = await ApiEngine.request(
      requestMethod: RequestMethod.get,
      path: "${EndPoints.user}/$id",
      options: Options(
        headers: <String, String>{
          "Authorization": "Bearer ${await AuthStore.getToken()}",
        },
      ),
    );
    return res;
  }

  static Future<ResponseModel> activation(String id, bool active) async {
    var mode = {true: "activate", false: "deactivate"};
    ResponseModel res = await ApiEngine.request(
      requestMethod: RequestMethod.post,
      path: "${EndPoints.user}/$id/${mode[active]}",
      options: Options(
        headers: <String, String>{
          "Authorization": "Bearer ${await AuthStore.getToken()}",
        },
      ),
    );
    return res;
  }

  static Future<ResponseModel> editUser(UserData userData, {password}) async {
    FormData data = FormData.fromMap(
        {"fullName": userData.fullName, "phone": "+966${userData.phone}"});
    if (password != null && password.isNotEmpty) {
      data.fields.add(MapEntry("password", password));
    }
    ResponseModel res = await ApiEngine.request(
      requestMethod: RequestMethod.patch,
      path: "${EndPoints.user}/${userData.id}",
      data: data,
      options: Options(
        headers: <String, String>{
          "Authorization": "Bearer ${await AuthStore.getToken()}",
        },
      ),
    );
    return res;
  }

  static Future<ResponseModel> addUser(
      UserData userData, String password) async {
    FormData data = FormData.fromMap({
      "fullName": userData.fullName,
      "phone": userData.phone,
      "type": userData.type
    });
    if (password.isNotEmpty) {
      data.fields.add(MapEntry("password", password));
    }
    ResponseModel res = await ApiEngine.request(
      requestMethod: RequestMethod.post,
      path: EndPoints.user,
      options: Options(
        headers: <String, String>{
          "Authorization": "Bearer ${await AuthStore.getToken()}",
        },
      ),
    );
    return res;
  }

  static Future<ResponseModel> deleteUser(String id) async {
    ResponseModel res = await ApiEngine.request(
      requestMethod: RequestMethod.delete,
      path: "${EndPoints.user}/$id",
      options: Options(
        headers: <String, String>{
          "Authorization": "Bearer ${await AuthStore.getToken()}",
        },
      ),
    );
    return res;
  }
}
