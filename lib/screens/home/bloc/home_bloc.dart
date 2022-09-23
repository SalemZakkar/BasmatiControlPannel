import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/model/model_export.dart';
import 'package:web_basmati/screens/home/model/user_model.dart';

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
    on<GetUserData>(_getUserData);
    on<GetUserEvent>(_getUser);
    on<UserActivation>(_userActivation);
    on<AddUserEvent>(_addUser);
    on<EditUserEvent>(_userEdit);
    on<DeleteUserEvent>(_deleteUser);
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

  _getUserData(GetUserData event, Emitter<HomeState> emit) async {
    emit(GetUserInfoState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true)));
    ResponseModel res = await HomeCore.getUserData(event.id);
    if (res.success) {
      UserModel userModel = UserModel.fromJson(jsonDecode(res.res?.data));
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus().copyWith(success: true),
          userData: userModel.data!));
    } else {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus().copyWith(
              failure: true, errorMessage: res.errorCode.toString())));
    }
  }

  _userActivation(UserActivation event, Emitter<HomeState> emit) async {
    emit(GetUserInfoState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true)));
    ResponseModel res = await HomeCore.activation(event.id, event.active);
    if (res.success) {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus().copyWith(success: true)));
    } else {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus()
              .copyWith(failure: true, errorMessage: res.errorCode)));
    }
  }

  _userEdit(EditUserEvent event, Emitter<HomeState> emit) async {
    emit(GetUserInfoState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true)));
    ResponseModel res =
        await HomeCore.editUser(event.data, password: event.password);
    if (res.success) {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus().copyWith(success: true)));
    } else {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus()
              .copyWith(failure: true, errorMessage: res.errorCode)));
    }
  }

  _deleteUser(DeleteUserEvent deleteUserEvent, Emitter<HomeState> emit) async {
    emit(GetUserInfoState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true)));
    ResponseModel res = await HomeCore.deleteUser(deleteUserEvent.id);
    if (res.success) {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus().copyWith(success: true)));
    } else {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus()
              .copyWith(failure: true, errorMessage: res.errorCode)));
    }
  }

  _addUser(AddUserEvent event, Emitter<HomeState> emit) async {
    emit(GetUserInfoState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true)));
    ResponseModel res = await HomeCore.addUser(event.data, event.password);
    if (res.success) {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus().copyWith(success: true)));
    } else {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus()
              .copyWith(failure: true, errorMessage: res.errorCode)));
    }
  }
}
