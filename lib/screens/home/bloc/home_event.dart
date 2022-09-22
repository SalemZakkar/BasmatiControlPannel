part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetUserInfoByTypeEvent extends HomeEvent {
  final bool searchByPhone;
  final String phoneNumber;
  final String type;

  const GetUserInfoByTypeEvent({
    required this.searchByPhone,
    required this.phoneNumber,
    required this.type,
  });
}

class GetUserEvent extends HomeEvent {
  final String? phone;
  final int? sub;
  final int type;
  final int skip, limit;
  const GetUserEvent(
      {this.phone,
      required this.type,
      this.sub,
      required this.skip,
      required this.limit});
}
