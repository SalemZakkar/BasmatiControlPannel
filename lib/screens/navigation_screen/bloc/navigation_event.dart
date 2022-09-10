part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigationChangeEvent extends NavigationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
  final int i;

  const NavigationChangeEvent({required this.i});
}
