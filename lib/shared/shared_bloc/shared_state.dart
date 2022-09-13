part of 'shared_bloc.dart';

abstract class SharedState {}

class SharedInitial extends SharedState {}

class RemoveStateAppInfo extends SharedState {
  final int id;
  RemoveStateAppInfo({required this.id});
}
