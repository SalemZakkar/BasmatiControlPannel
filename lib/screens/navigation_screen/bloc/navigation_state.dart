part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationInitial extends NavigationState {
  @override
  List<Object> get props => [];
}

class NavigationChangedState extends NavigationState {
  final int i;

  const NavigationChangedState({required this.i});

  @override
  List<Object?> get props => [];
}
