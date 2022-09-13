import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/core/app_info/app_info_core.dart';
import 'package:web_basmati/screens/app_information/models/app_info_model.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';

part 'app_info_event.dart';
part 'app_info_state.dart';

class AppInfoBloc extends Bloc<AppInfoEvent, AppInfoState> {
  AppInfoBloc() : super(AppInfoInitial()) {
    on<AppInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AppInfoGetEvent>(_getInfo);
    on<AppInfoUpdateEvent>(_updateInfo);
  }

  _getInfo(AppInfoGetEvent event, Emitter<AppInfoState> emit) async {
    emit(AppInfoLoading());
    ResponseModel res = await AppInfoCore.getAppInfo();
    if (res.success) {
      AppInfoModel data = AppInfoModel.fromJson(jsonDecode(res.res?.data));
      emit(GetAppInfoSuccess(appInfoModel: data));
    } else {
      emit(AppInfoFail(code: res.errorCode ?? ""));
    }
  }

  _updateInfo(AppInfoUpdateEvent event, Emitter<AppInfoState> emit) async {
    emit(AppInfoLoading());
    ResponseModel res = await AppInfoCore.updateAppInfo(event.data);
    if (res.success) {
      emit(UpdateAppInfoSuccess());
    } else {
      emit(AppInfoFail(code: res.errorCode ?? ""));
    }
  }
}
