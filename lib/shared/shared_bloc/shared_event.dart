part of 'shared_bloc.dart';

abstract class SharedEvent {}

class RemoveEventAppInfo extends SharedEvent {
  final int id;
  RemoveEventAppInfo({required this.id});
}

class GetUsersSharedEvent extends SharedEvent {
  final int skip, limit;
  GetUsersSharedEvent({required this.skip, required this.limit});
}

class ResetUserEvent extends SharedEvent {}
