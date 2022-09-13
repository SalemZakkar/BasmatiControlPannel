import 'package:dio/dio.dart';

import '../web_connection.dart';

enum RequestMethod { post, get, patch, delete, put }

Future<Response> sendRequest(
    {required RequestMethod requestMethod,
    required path,
    Map<String, dynamic>? queryParameters,
    var data,
    Options? options}) async {
  Response? response;
  //String endPath = (pathVar == null ? path + "/" + pathVar + "/" : path);
  switch (requestMethod) {
    case RequestMethod.post:
      response = await myDio.post(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      break;
    case RequestMethod.get:
      response = await myDio.get(
        path,
        options: options,
        queryParameters: queryParameters,
      );
      break;
    case RequestMethod.put:
      response = await myDio.put(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      break;
    case RequestMethod.delete:
      response = await myDio.delete(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      break;
    case RequestMethod.patch:
      response = await myDio.patch(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      break;
  }
  return response;
}
