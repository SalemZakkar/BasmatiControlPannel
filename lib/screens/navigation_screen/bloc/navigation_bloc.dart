import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NavigationChangeEvent>(_onChangeNavigation);
  }

  _onChangeNavigation(
      NavigationChangeEvent event, Emitter<NavigationState> emit) {
    emit(NavigationChangedState(i: event.i));
    emit(NavigationInitial());
  }
}
