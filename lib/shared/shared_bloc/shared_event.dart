part of 'shared_bloc.dart';


abstract class SharedEvent {}

class RemoveEvent extends SharedEvent {
  final int id;
  RemoveEvent({required this.id});
}
