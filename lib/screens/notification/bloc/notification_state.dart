part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  final bool? success;
  final bool? fail;
  final bool? waiting;
  final String? errorCode;
  const NotificationState(
      {this.success, this.errorCode, this.fail, this.waiting});
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotifyState extends NotificationState {
  @override
  List<Object?> get props => [success, fail, errorCode, waiting];
  const NotifyState(
      {super.errorCode, super.fail, super.success, super.waiting});
}
