part of 'shared_bloc.dart';

abstract class SharedState {}

class SharedInitial extends SharedState {}

class RemoveState extends SharedState {
  final int id;
  RemoveState({required this.id});
}
