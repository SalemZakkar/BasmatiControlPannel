import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/core/auth/auth_core.dart';
import 'package:web_basmati/screens/authentication/models/mine_model.dart';
import 'package:web_basmati/screens/authentication/models/token_data.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';

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
    List<ResponseModel> res = await Future.wait<ResponseModel>(
        [AuthCore.login(event.phone, event.password)]);
    ResponseModel response = res[0];
    if (response.success) {
      AuthStore.setAuthInfo(event.phone, event.password);
      AuthStore.setToken(TokenData.fromJson(jsonDecode(response.res?.data!)));
      ResponseModel response2 = await AuthCore.getMine();
      if (response2.success) {
        MineModel model = MineModel.fromJson(jsonDecode(response2.res?.data));
        if (model.data?.type == "Customer") {
          emit(const AuthError(code: "0620"));
          return;
        }
        if (model.data?.isActive == false) {
          emit(const AuthError(code: "0626"));
          return;
        }
      } else {
        emit(AuthError(code: response2.errorCode.toString()));
        return;
      }
      emit(AuthSuccess());
    } else {
      emit(AuthError(code: response.errorCode!));
    }
  }
}
