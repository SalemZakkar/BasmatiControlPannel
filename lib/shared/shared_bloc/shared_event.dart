part of 'shared_bloc.dart';

abstract class SharedEvent {}

class RemoveEventAppInfo extends SharedEvent {
  final int id;
  RemoveEventAppInfo({required this.id});
}
