import 'package:flutter_bloc/flutter_bloc.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  SharedBloc() : super(SharedInitial()) {
    on<SharedEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RemoveEventAppInfo>((event, emit) {
      emit(RemoveStateAppInfo(id: event.id));
    });
    on<GetUsersSharedEvent>((event, emit) {
      emit(GetUsersState(skip: event.skip, limit: event.limit));
    });
    on<ResetUserEvent>((event, emit) {
      emit(ResetUserState());
    });
    on<ResetItemEvent>((event, emit) {
      emit(ResetItemsState());
    });
  }
}
