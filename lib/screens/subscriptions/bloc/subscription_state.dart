part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  final bool? wait, success, fail;
  final String? errorCode;
  final SubscriptionModel? subscriptionModel;
  const SubscriptionState(
      {this.errorCode,
      this.subscriptionModel,
      this.fail,
      this.success,
      this.wait});
}

class SubscriptionInitial extends SubscriptionState {
  @override
  List<Object> get props => [];
}

class SubState extends SubscriptionState {
  const SubState(
      {super.errorCode,
      super.fail,
      super.success,
      super.wait,
      super.subscriptionModel});
  @override
  List<Object?> get props => [
        super.errorCode,
        super.fail,
        super.success,
        super.wait,
        super.subscriptionModel
      ];
}
