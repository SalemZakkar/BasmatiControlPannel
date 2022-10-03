import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:web_basmati/screens/authentication/models/token_data.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
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

  static Future<ResponseModel> getMine() async {
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.get,
        path: EndPoints.userMine,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    return res;
  }

  static Future<ResponseModel> refreshToken() async {
    ResponseModel model = await ApiEngine.request(
      requestMethod: RequestMethod.post,
      path: EndPoints.refreshToken,
      data: {"token": await AuthStore.getRefresh()},
    );
    if (model.success) {
      TokenData tokenData = TokenData.fromJson(jsonDecode(model.res?.data));
      await AuthStore.setToken(tokenData);
    }
    return model;
  }

  static Future<ResponseModel> loginStore() async {
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: EndPoints.signIn,
        data: {
          "phone": await AuthStore.getPhone(),
          "password": await AuthStore.getPass()
        });
    return res;
  }
}
