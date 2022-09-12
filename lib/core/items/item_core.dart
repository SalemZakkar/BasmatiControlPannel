import 'dart:io';

import 'package:dio/dio.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/screens/items/model/item_details_model.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

class ItemsCore {
  static Future<Response> getItems(String skip, String limit, String? name,
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
    Response res = await myDio.get(EndPoints.item,
        queryParameters: params,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<Response> getItemsByName(String name) async {
    String token = await AuthStore.getToken() ?? "";
    Response res = await myDio.get(EndPoints.item,
        queryParameters: {"total": true, "name": name},
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<Response> getItemsByPrice(String low, String high) async {
    String token = await AuthStore.getToken() ?? "";
    Response res = await myDio.get(EndPoints.item,
        queryParameters: {"total": true, "price[gte]": low, "price[lte]": high},
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<Response> getItemDetails(String id) async {
    String token = await AuthStore.getToken() ?? "";
    Response res = await myDio.get("${EndPoints.item}/$id",
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

  static Future<Response> updateItem(ItemDetailsModel data) async {
    String token = await AuthStore.getToken() ?? "";
    Map<String, dynamic> form = {};
    form["name"] = data.data?.name;
    form["description"] = data.data?.description;
    form["images"] = data.data?.images;
    form["price"] = data.data?.price;
    form["isSpecial"] = data.data?.isSpecial;
    form["isActive"] = data.data?.isActive;
    form["fullPrice"] = data.data?.fullPrice;
    Response res = await myDio.patch("${EndPoints.item}/${data.data!.id}",
        data: form,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<Response> uploadImage(String id, MultipartFile file) async {
    String token = await AuthStore.getToken() ?? "";
    Response res = await myDio.post("${EndPoints.item}/$id/file",
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
        data: FormData.fromMap({
          "images": [file]
        }));
    return res;
  }

  static Future<Response> deleteImage(String id, String itemId) async {
    String token = await AuthStore.getToken() ?? "";
    Response res = await myDio.delete("${EndPoints.item}/$itemId/$id",
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }

  static Future<Response> deleteProduct(String id) async {
    String token = await AuthStore.getToken() ?? "";
    Response res = await myDio.delete("${EndPoints.item}/$id",
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    return res;
  }
}
