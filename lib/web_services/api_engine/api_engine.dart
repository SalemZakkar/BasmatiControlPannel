import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';

import '../../helper/error_data.dart';
import '../endpoint.dart';
import '../web_connection.dart';
import 'enum.dart';

class ApiEngine {
  static void initDio() {
    myDio = Dio(
      BaseOptions(
        connectTimeout: 12000,
        receiveTimeout: 12000,
        sendTimeout: 12000,
        validateStatus: (code) {
          return (code ?? 500) <= 500;
        },
        headers: {
          "Accept": "*/*",
          "Connection": "keep-alive",
        },
        baseUrl: EndPoints.baseUrl,
        responseType: ResponseType.plain,
      ),
    );
    myDio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        responseHeader: true,
        requestHeader: true,
        request: true,
      ),
    );
  }

  static Future<ResponseModel> request<T>(
      {required RequestMethod requestMethod,
      required path,
      String? pathVar,
      Map<String, dynamic>? queryParameters,
      var data,
      Options? options}) async {
    ResponseModel res;
    try {
      Response response = await sendRequest(

        requestMethod: requestMethod,
        path: path,
        queryParameters: queryParameters,
        options: options,
        data: data,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        res = ResponseModel(success: true, res: response);
      } else {
        debugPrint(
            "------------------------------------------------------------------------");
        debugPrint("ServerError");
        debugPrint(response.data);
        debugPrint(
            "------------------------------------------------------------------------");
        ErrorData errorData = ErrorData.fromJson(jsonDecode(response.data));
        res =
            ResponseModel(success: false, errorCode: errorData.code ?? "8870");
      }
    } on DioError catch (e) {
      debugPrint(
          "------------------------------------------------------------------------");
      debugPrint("DioError");
      debugPrint(e.toString());
      debugPrint(
          "------------------------------------------------------------------------");
      if (e.type == DioErrorType.response && e.response!=null) {
        try{
          ErrorData errorData = ErrorData.fromJson(jsonDecode(e.response?.data));
          res = ResponseModel(success: false, errorCode: errorData.code ?? "");
        }catch(e){
          res = ResponseModel(success: false , errorCode: "7787");
        }
      } else if (e.message == "XMLHttpRequest error." ||
          e.type == DioErrorType.connectTimeout ||
          e.error is SocketException ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        print('*&***********************************************************');
        res = ResponseModel(success: false, errorCode: "7");
      } else {
        res = ResponseModel(success: false, errorCode: "8872");
      }
    } on FormatException {
      debugPrint(
          "------------------------------------------------------------------------");
      debugPrint("FormatError");
      debugPrint(
          "------------------------------------------------------------------------");
      res = ResponseModel(success: false, errorCode: "02210");
    } catch (e) {
      debugPrint(
          "------------------------------------------------------------------------");
      debugPrint("Other");
      debugPrint(e.toString());
      debugPrint(
          "------------------------------------------------------------------------");
      res = ResponseModel(success: false, errorCode: "9976");
    }
    return res;
  }
}
