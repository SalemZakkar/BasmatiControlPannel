import 'dart:io';

import 'package:dio/dio.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/screens/subscriptions/model/subscription_model.dart';
import 'package:web_basmati/web_services/api_engine/api_engine.dart';
import 'package:web_basmati/web_services/api_engine/enum.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

import '../../web_services/api_engine/response_model.dart';

class SubscriptionCore {
  static Future<ResponseModel> getSubscription(int skip, int limit) async {
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.get,
        path: EndPoints.subscription,
        queryParameters: {"skip": skip, "limit": limit, "total": true},
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    return res;
  }

  static Future<ResponseModel> editSubscription(
      SubscriptionData subscriptionData) async {
    Map<String, dynamic> data = {};
    data['name'] = subscriptionData.name;
    data['description'] = subscriptionData.description;
    data['price'] = subscriptionData.price;
    data['duration'] = subscriptionData.duration?.toJson();
    data['isActive'] = subscriptionData.isActive;
    if (subscriptionData.discount != 0) {
      data['discount'] = subscriptionData.discount;
    }
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.patch,
        path: "${EndPoints.subscription}/${subscriptionData.id}",
        data: data,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    return res;
  }

  static Future<ResponseModel> addSubscription(
      SubscriptionData subscriptionData) async {
    Map<String, dynamic> data = {};
    data['name'] = subscriptionData.name;
    data['description'] = subscriptionData.description;
    data['price'] = subscriptionData.price;
    data['isActive'] = true;
    data['duration'] = subscriptionData.duration?.toJson();
    if (subscriptionData.discount != null) {
      data['discount'] = subscriptionData.discount;
    }

    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: EndPoints.subscription,
        data: data,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    return res;
  }

  static Future<ResponseModel> delete(String id) async {
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.delete,
        path: '${EndPoints.subscription}/$id',
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    return res;
  }
}
