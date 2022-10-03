import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/model/model_export.dart';
import 'package:web_basmati/screens/home/model/order_details_model.dart';
import 'package:web_basmati/screens/home/model/order_logs_model.dart';
import 'package:web_basmati/screens/home/model/subscription_details_model.dart';
import 'package:web_basmati/screens/home/model/subscription_log_model.dart';
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
    on<Subscribe>(_subscribe);
    on<GetOrderLogs>(_getOrderLog);
    on<GetOrderDetails>(_getOrderDetails);
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

  _getOrderLog(GetOrderLogs event, Emitter<HomeState> emit) async {
    emit(GetUserInfoState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true)));
    ResponseModel res = await HomeCore.getOrderLogs(
        event.skip, event.limit, event.sub, event.id);
    if (res.success) {
      late OrderLogsModel model;
      late SubscriptionLogModel sModel;
      if (event.sub) {
        sModel = SubscriptionLogModel.fromJson(jsonDecode(res.res?.data));
        emit(GetUserInfoState(
            stateStatusUserInfo: StateStatus(success: true),
            subscriptionLogModel: sModel));
      } else {
        model = OrderLogsModel.fromJson(jsonDecode(res.res?.data));
        emit(GetUserInfoState(
            stateStatusUserInfo: StateStatus(success: true),
            orderLogsModel: model));
      }
    } else {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus()
              .copyWith(failure: true, errorMessage: res.errorCode)));
    }
  }

  _getOrderDetails(GetOrderDetails event, Emitter<HomeState> emit) async {
    emit(GetUserInfoState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true)));
    ResponseModel res = await HomeCore.getOrderDetails(event.id);
    if (res.success) {
      late SubscriptionDetailsModel model;
      late OrderDetailsModel oModel;
      if (event.sub) {
        model = SubscriptionDetailsModel.fromJson(jsonDecode(res.res?.data));
        emit(GetUserInfoState(
            stateStatusUserInfo: StateStatus(success: true),
            subscriptionDetailsData: model.data));
      } else {
        oModel = OrderDetailsModel.fromJson(jsonDecode(res.res?.data));
        emit(GetUserInfoState(
            stateStatusUserInfo: StateStatus(success: true),
            orderDetailsData: oModel.data));
      }
    } else {
      emit(GetUserInfoState(
          stateStatusUserInfo: StateStatus()
              .copyWith(failure: true, errorMessage: res.errorCode)));
    }
  }

  _subscribe(Subscribe event, Emitter<HomeState> emit) async {
    emit(GetUserInfoState(
        stateStatusUserInfo: StateStatus().copyWith(inProgress: true)));
    ResponseModel res = await HomeCore.subscribe(event.id, event.sId);
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
