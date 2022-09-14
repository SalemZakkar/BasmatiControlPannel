part of 'app_info_bloc.dart';

abstract class AppInfoEvent {}

class AppInfoGetEvent extends AppInfoEvent {}

class AppInfoUpdateEvent extends AppInfoEvent {
  AppInfoData data;
  AppInfoUpdateEvent({required this.data});
}
