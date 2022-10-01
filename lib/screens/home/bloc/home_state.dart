part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final StateStatus stateStatusUserInfo;
  final UserInfoType userInfoTypeList;
  final UserData? userData;
  final SubscriptionLogModel? subscriptionLogModel;
  final SubscriptionDetailsData? subscriptionDetailsData;
  final OrderLogsModel? orderLogsModel;
  final OrderDetailsData? orderDetailsData;
  const HomeState(
      {required this.stateStatusUserInfo,
      required this.userInfoTypeList,
      this.subscriptionLogModel,
      this.subscriptionDetailsData,
      this.orderDetailsData,
      this.orderLogsModel,
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
  GetUserInfoState(
      {required super.stateStatusUserInfo,
      super.userData,
      super.orderDetailsData,
      super.orderLogsModel,
      super.subscriptionDetailsData,
      super.subscriptionLogModel})
      : super(userInfoTypeList: UserInfoType());
}
