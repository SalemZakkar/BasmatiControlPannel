part of 'items_bloc.dart';

abstract class ItemsEvent {}

class RemoveItemEvent extends ItemsEvent {
  final int i;

  RemoveItemEvent({required this.i});
}

class ItemAddEvent extends ItemsEvent {
  final ItemDetailsModel itemModel;
  List<Uint8List> bytes;

  ItemAddEvent({required this.itemModel, required this.bytes});
}

class ItemGetEvent extends ItemsEvent {
  final String skip;
  final String limit;
  String? name, low, high;
  ItemGetEvent(
      {required this.skip,
      required this.limit,
      this.name,
      this.low,
      this.high});
}

class ItemGetByName extends ItemsEvent {
  final String name;
  ItemGetByName({required this.name});
}

class ItemGetByPrice extends ItemsEvent {
  final String low, high;
  ItemGetByPrice({required this.low, required this.high});
}

class ItemGetDetails extends ItemsEvent {
  final String id;
  ItemGetDetails({required this.id});
}

class GetItemImage extends ItemsEvent {
  String id;
  GetItemImage({required this.id});
}

class UpdateProductEvent extends ItemsEvent {
  final ItemDetailsModel itemDetailsModel;
  UpdateProductEvent({required this.itemDetailsModel});
}

class UploadImageEvent extends ItemsEvent {
  final String id;
  final Uint8List bytes;
  UploadImageEvent({required this.id, required this.bytes});
}

class DeleteEvent extends ItemsEvent {
  final String id;
  DeleteEvent({required this.id});
}

class DeleteImageEvent extends ItemsEvent {
  final String id;
  final String itemId;
  DeleteImageEvent({required this.id, required this.itemId});
}

class Deactivate extends ItemsEvent {
  final String id;
  Deactivate({required this.id});
}
