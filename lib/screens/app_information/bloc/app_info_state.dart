part of 'app_info_bloc.dart';

abstract class AppInfoState {}

class AppInfoInitial extends AppInfoState {}

class AppInfoLoading extends AppInfoState {}

class GetAppInfoSuccess extends AppInfoState {
  AppInfoModel appInfoModel;
  GetAppInfoSuccess({required this.appInfoModel});
}

class UpdateAppInfoSuccess extends AppInfoState {

}

class AppInfoFail extends AppInfoState {
  String code;
  AppInfoFail({required this.code});
}