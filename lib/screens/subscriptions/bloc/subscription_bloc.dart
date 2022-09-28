import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/core/subscription/subscription_core.dart';
import 'package:web_basmati/screens/subscriptions/model/subscription_model.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(SubscriptionInitial()) {
    on<SubscriptionEvent>((event, emit) {
    });
    on<AddSubscription>(_addSubscription);
    on<EditSubscription>(_editSubscription);
    on<DeleteSubscription>(_deleteSubscription);
    on<GetSubscriptions>(_getSubscriptions);
  }
  _addSubscription(
      AddSubscription event, Emitter<SubscriptionState> emit) async {
    emit(const SubState(wait: true));
    ResponseModel res =
        await SubscriptionCore.addSubscription(event.subscriptionData);
    if (res.success) {
      emit(const SubState(success: true));
    } else {
      emit(SubState(fail: true, errorCode: res.errorCode));
    }
  }

  _editSubscription(
      EditSubscription event, Emitter<SubscriptionState> emit) async {
    emit(const SubState(wait: true));
    ResponseModel res =
        await SubscriptionCore.editSubscription(event.subscriptionData);
    if (res.success) {
      emit(const SubState(success: true));
    } else {
      emit(SubState(fail: true, errorCode: res.errorCode));
    }
  }

  _deleteSubscription(
      DeleteSubscription event, Emitter<SubscriptionState> emit) async {
    emit(const SubState(wait: true));
    ResponseModel res = await SubscriptionCore.delete(event.id);
    if (res.success) {
      emit(const SubState(success: true));
    } else {
      emit(SubState(fail: true, errorCode: res.errorCode));
    }
  }

  _getSubscriptions(
      GetSubscriptions event, Emitter<SubscriptionState> emit) async {
    emit(const SubState(wait: true));
    ResponseModel res =
        await SubscriptionCore.getSubscription(event.skip, event.limit);
    if (res.success) {
      SubscriptionModel subscriptionModel =
          SubscriptionModel.fromJson(jsonDecode(res.res?.data));
      emit(SubState(success: true, subscriptionModel: subscriptionModel));
    } else {
      emit(SubState(fail: true, errorCode: res.errorCode));
    }
  }
}
