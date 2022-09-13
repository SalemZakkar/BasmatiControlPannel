import 'package:web_basmati/web_services/api_engine/api_engine.dart';
import 'package:web_basmati/web_services/api_engine/enum.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';
import 'package:web_basmati/web_services/endpoint.dart';

class AuthCore {
  static Future<ResponseModel> login(String phone, String password) async {
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: EndPoints.signIn,
        data: {"phone": phone, "password": password});
    return res;
  }
}
