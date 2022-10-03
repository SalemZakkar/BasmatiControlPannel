part of 'shared_bloc.dart';

abstract class SharedState {}

class SharedInitial extends SharedState {}

class RemoveStateAppInfo extends SharedState {
  final int id;
  RemoveStateAppInfo({required this.id});
}

class GetUsersState extends SharedState {
  final int skip, limit;
  GetUsersState({required this.skip, required this.limit});
}

class ResetUserState extends SharedState {}

class ResetItemsState extends SharedState {}

class ResetAppState extends SharedState {}
