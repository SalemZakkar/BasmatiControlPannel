import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/model/model_export.dart';

import '../../../core/home/home_core.dart';
import '../../../web_services/api_engine/response_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeInitial(
          stateStatusUserInfo: StateStatus(),
          userInfoTypeList: UserInfoType(),
        )) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetUserInfoByTypeEvent>(_getUserInfoByTypeEvent);
  }

  _getUserInfoByTypeEvent(GetUserInfoByTypeEvent event, Emitter<HomeState> emit) async {
    emit(GetUserInfoByState(
        stateStatusUserInfo:
            StateStatus().copyWith(inProgress: true, success: false, failure: false),
        userInfoTypeList: UserInfoType()));

    Map<String, String> sendData = {};
    if (event.searchByPhone == true) {
      sendData = {"phone": event.phoneNumber};
    } else {
      if (event.type == "عميل") {
        sendData = {"type": "Customer"};
      }
      if (event.type == "مشرف") {
        sendData = {"type": "Admin"};
      }

      if (event.type == "مشترك") {
        sendData = {"isActive": "true"};
      }
      if (event.type == "غير مشترك") {
        sendData = {"isActive": "false"};
      }
    }

    ResponseModel res = await HomeCore.getUserInfoByType(sendData);
    if (res.success) {
      UserInfoType data = UserInfoType.fromJson(jsonDecode(res.res?.data));

      emit(GetUserInfoByState(
          stateStatusUserInfo: StateStatus().copyWith(inProgress: false, success: true),
          userInfoTypeList: data));
    } else {
      emit(GetUserInfoByState(
          stateStatusUserInfo: StateStatus()
              .copyWith(inProgress: false, failure: true, errorMessage: res.errorCode),
          userInfoTypeList: state.userInfoTypeList));
    }
  }
}
