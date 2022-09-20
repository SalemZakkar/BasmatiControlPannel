part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final StateStatus stateStatusUserInfo;
  final UserInfoType userInfoTypeList;
  const HomeState({required this.stateStatusUserInfo,required this.userInfoTypeList});

  @override
  List<Object> get props => [stateStatusUserInfo,userInfoTypeList];
}

class HomeInitial extends HomeState {
  const HomeInitial({required super.stateStatusUserInfo, required super.userInfoTypeList});
}

class GetUserInfoByState extends HomeState{
  const GetUserInfoByState({required super.stateStatusUserInfo, required super.userInfoTypeList});
}
