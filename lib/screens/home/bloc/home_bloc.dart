import 'dart:convert';

import 'package:equatable/equatable.dart';
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
    on<GetUserEvent>(_getUser);
  }
  _getUser(GetUserEvent event, Emitter<HomeState> emit) async {
    emit(GetUserInfoByState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true),
        userInfoTypeList: UserInfoType()));
    ResponseModel res = await HomeCore.getUser(
        event.skip, event.limit, event.phone, event.type, event.sub);
    if (res.success) {
      UserInfoType userInfoType =
          UserInfoType.fromJson(jsonDecode(res.res?.data));
      emit(GetUserInfoByState(
          stateStatusUserInfo: StateStatus().copyWith(success: true),
          userInfoTypeList: userInfoType));
    } else {
      emit(GetUserInfoByState(
          stateStatusUserInfo: StateStatus()
              .copyWith(failure: true, errorMessage: res.errorCode ?? "999"),
          userInfoTypeList: UserInfoType()));
    }
  }
}
