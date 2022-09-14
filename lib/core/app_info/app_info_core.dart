import 'dart:io';

import 'package:dio/dio.dart';
import 'package:web_basmati/screens/app_information/models/app_info_model.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/web_services/api_engine/api_engine.dart';
import 'package:web_basmati/web_services/api_engine/enum.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

import '../../web_services/api_engine/response_model.dart';

class AppInfoCore {
  static Future<ResponseModel> getAppInfo() async {
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.get,
        path: EndPoints.about,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    return res;
  }

  static Future<ResponseModel> updateAppInfo(AppInfoData data) async {
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.patch,
        path: EndPoints.about,
        data: {"whatsApp": data.phones, "description": data.description},
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    return res;
  }
}
