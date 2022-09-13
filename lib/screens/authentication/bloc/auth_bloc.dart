import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/core/auth/auth_core.dart';
import 'package:web_basmati/helper/error_data.dart';
import 'package:web_basmati/helper/helper_export.dart';
import 'package:web_basmati/screens/authentication/models/token_data.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/web_services/api_engine/api_engine.dart';
import 'package:web_basmati/web_services/api_engine/enum.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignInEvent>(_login);
  }

  _login(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // try {
    //   printLog(stateID: "1", data: "login Loading", isSuccess: false);
    //   Response res = await AuthCore.login(event.phone, event.password);
    //   if (res.statusCode == 200 || res.statusCode == 201) {
    //     AuthStore.setAuthInfo(event.phone, event.password);
    //     AuthStore.setToken(TokenData.fromJson(jsonDecode(res.data)));
    //     emit(AuthSuccess());
    //   } else {
    //     ErrorData errorData = ErrorData.fromJson(jsonDecode(res.data));
    //     emit(AuthError(code: errorData.code ?? "999"));
    //   }
    // } on DioError catch (e) {
    //   if (e.error is SocketException ||
    //       e.type == DioErrorType.connectTimeout ||
    //       e.type.index == 3) {
    //     emit(const AuthError(code: "7"));
    //   } else {
    //     emit(const AuthError(code: "999"));
    //   }
    // } catch (e) {
    //   emit(const AuthError(code: "999"));
    // }
    ResponseModel response = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: EndPoints.signIn,
        data: {"phone": event.phone, "password": event.password});
    if (response.success) {
      AuthStore.setAuthInfo(event.phone, event.password);
      AuthStore.setToken(TokenData.fromJson(jsonDecode(response.res?.data!)));
      emit(AuthSuccess());
    } else {
      emit(AuthError(code: response.errorCode!));
    }
  }
}
