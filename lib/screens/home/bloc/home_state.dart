part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final StateStatus stateStatusUserInfo;
  final UserInfoType userInfoTypeList;
  final UserData? userData;
  const HomeState(
      {required this.stateStatusUserInfo,
      required this.userInfoTypeList,
      this.userData});

  @override
  List<Object> get props =>
      [stateStatusUserInfo, userInfoTypeList, userData ?? UserData()];
}

class HomeInitial extends HomeState {
  const HomeInitial(
      {required super.stateStatusUserInfo, required super.userInfoTypeList});
}

class GetUserInfoByState extends HomeState {
  const GetUserInfoByState(
      {required super.stateStatusUserInfo, required super.userInfoTypeList});
}

class GetUserInfoState extends HomeState {
  GetUserInfoState({
    required super.stateStatusUserInfo,
    super.userData,
  }) : super(userInfoTypeList: UserInfoType());
}
