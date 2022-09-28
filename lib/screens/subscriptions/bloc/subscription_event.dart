part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
}

class AddSubscription extends SubscriptionEvent {
  final SubscriptionData subscriptionData;
  const AddSubscription({required this.subscriptionData});

  @override
  List<Object?> get props => [subscriptionData];
}

class EditSubscription extends SubscriptionEvent {
  final SubscriptionData subscriptionData;
  const EditSubscription({required this.subscriptionData});

  @override
  List<Object?> get props => [subscriptionData];
}

class GetSubscriptions extends SubscriptionEvent {
  final int skip, limit;
  const GetSubscriptions({required this.skip, required this.limit});

  @override
  List<Object?> get props => [skip, limit];
}

class DeleteSubscription extends SubscriptionEvent {
  final String id;
  const DeleteSubscription({required this.id});

  @override
  List<Object?> get props => [id];
}
