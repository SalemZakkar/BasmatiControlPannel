part of 'items_bloc.dart';

abstract class ItemsState {}

class ItemsInitial extends ItemsState {}

class RemoveItemState extends ItemsState {
  final int i;

  RemoveItemState({required this.i});
}

class ItemsLoading extends ItemsState {}

class AddItemProgress extends ItemsState {
  final double progress;

  AddItemProgress({required this.progress});
}

class ItemsFail extends ItemsState {
  final String code;

  ItemsFail({required this.code});
}



class ItemSuccess extends ItemsState {}

class GetItemSuccess extends ItemsState {
  final GetItemsModel data;

  GetItemSuccess({required this.data});
}

class GetItemDetailsSuccess extends ItemsState {
  final ItemDetailsModel itemDetailsModel;
  GetItemDetailsSuccess({required this.itemDetailsModel});
}

class GetItemImageSuccess extends ItemsState {
  final String url;
  GetItemImageSuccess({required this.url});
}

class ItemsSending extends ItemsState {}

class GetItemDetailsFail extends ItemsState {}
