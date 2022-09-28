import 'dart:io';

import 'package:dio/dio.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/screens/notification/model/notification_model.dart';
import 'package:web_basmati/web_services/api_engine/api_engine.dart';
import 'package:web_basmati/web_services/api_engine/enum.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

import '../../screens/notification/model/notification_model.dart';
import '../../web_services/api_engine/response_model.dart';

class NotificationCore {
  static Future<ResponseModel> notify(
      List<String> ids, NotificationData notificationData) async {
    Map<String, dynamic> data = {
      "title": notificationData.title.toString(),
      "body": notificationData.body.toString(),
    };
    if (ids.isNotEmpty) {
      data["users"] = ids;
    }
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: EndPoints.notification,
        data: data,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    return res;
  }
}
