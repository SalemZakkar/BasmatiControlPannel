import 'package:dio/dio.dart';

class ResponseModel {
  bool success;
  String? errorCode;
  Response? res;
  ResponseModel({required this.success, this.errorCode, this.res});
}
