part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class NotifyEvent extends NotificationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
  final List<String> ids;
  final NotificationData data;
  const NotifyEvent({required this.data, required this.ids});
}
