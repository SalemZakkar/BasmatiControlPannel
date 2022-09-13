import 'dart:io';

import 'package:dio/dio.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/screens/items/model/item_details_model.dart';
import 'package:web_basmati/web_services/api_engine/api_engine.dart';
import 'package:web_basmati/web_services/api_engine/enum.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

class ItemsCore {
  static Future<ResponseModel> addItem(
      ItemDetailsModel itemModel, List<MultipartFile> files) async {
    String token = await AuthStore.getToken() ?? "";
    Map<String, dynamic> form = {
      "name": itemModel.data?.name!.trim(),
      "description": itemModel.data?.description!.trim(),
      "price": itemModel.data?.price,
      "images": files,
      "isActive": itemModel.data!.isActive,
      "isSpecial": itemModel.data!.isSpecial,
      "fullPrice": itemModel.data!.fullPrice,
    };
    if (itemModel.data!.warranty?.value != null) {
      form["warranty[unit]"] = "month";
      form["warranty[value]"] = itemModel.data!.warranty?.value;
    }
    FormData formData = FormData.fromMap(form);
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: EndPoints.item,
        data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            sendTimeout: 25000));
    return res;
  }

  static Future<ResponseModel> getItems(String skip, String limit, String? name,
      String? low, String? high) async {
    String token = await AuthStore.getToken() ?? "";
    Map<String, dynamic> params = {};
    params.putIfAbsent("total", () => true);
    params.putIfAbsent("skip", () => skip);
    params.putIfAbsent("limit", () => limit);
    if (name != null) {
      params.putIfAbsent("name", () => name);
    }
    if (low != null) {
      params.putIfAbsent("price[gte]", () => low);
    }
    if (high != null) {
      params.putIfAbsent("price[lte]", () => high);
    }
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.get,
        path: EndPoints.item,
        queryParameters: params,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<ResponseModel> getItemDetails(String id) async {
    String token = await AuthStore.getToken() ?? "";
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.get,
        path: "${EndPoints.item}/$id",
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<Response> getImage(String id) async {
    String token = await AuthStore.getToken() ?? "";
    Response res = await myDio.get("${EndPoints.imagePath}/$id",
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<ResponseModel> updateItem(ItemDetailsModel data) async {
    String token = await AuthStore.getToken() ?? "";
    Map<String, dynamic> form = {};
    form["name"] = data.data?.name;
    form["description"] = data.data?.description;
    form["images"] = data.data?.images;
    form["price"] = data.data?.price;
    form["isSpecial"] = data.data?.isSpecial;
    form["isActive"] = data.data?.isActive;
    form["fullPrice"] = data.data?.fullPrice;
    if (data.data!.warranty?.value != null) {
      form["warranty"] = data.data!.warranty?.toJson();
    }
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.patch,
        path: "${EndPoints.item}/${data.data!.id!}",
        data: form,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<ResponseModel> uploadImage(
      String id, MultipartFile file) async {
    String token = await AuthStore.getToken() ?? "";
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: "${EndPoints.item}/$id/file",
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            sendTimeout: 25000),
        data: FormData.fromMap({
          "images": [file]
        }));
    return res;
  }

  static Future<ResponseModel> deleteImage(String id, String itemId) async {
    String token = await AuthStore.getToken() ?? "";
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.delete,
        path: "${EndPoints.item}/$itemId/$id",
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<ResponseModel> deleteProduct(String id) async {
    String token = await AuthStore.getToken() ?? "";
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.delete,
        path: "${EndPoints.item}/$id",
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }
}
