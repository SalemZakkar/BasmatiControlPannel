import 'package:flutter_bloc/flutter_bloc.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  SharedBloc() : super(SharedInitial()) {
    on<SharedEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RemoveEvent>((event, emit) {
      emit(RemoveState(id: event.id));
    });
  }
}
