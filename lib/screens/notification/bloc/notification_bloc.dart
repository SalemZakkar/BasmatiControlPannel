import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/core/notification/notification_core.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';

import '../../notification/model/notification_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) {
    });
    on<NotifyEvent>(_notify);
  }
  _notify(NotifyEvent event, Emitter<NotificationState> emit) async {
    emit(const NotifyState(waiting: true));
    ResponseModel res = await NotificationCore.notify(event.ids, event.data);
    if (res.success) {
      emit(const NotifyState(success: true));
    } else {
      emit(NotifyState(fail: true, errorCode: res.errorCode.toString()));
    }
  }
}
