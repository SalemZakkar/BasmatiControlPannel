import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:web_basmati/core/items/item_core.dart';
import 'package:web_basmati/screens/items/model/get_items_model.dart';
import 'package:web_basmati/screens/items/model/item_details_model.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<ItemsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RemoveItemEvent>(_removePhoto);
    on<ItemAddEvent>(_addItem);
    on<ItemGetEvent>(_getItemsCriteria);
    on<ItemGetDetails>(_getItemDetails);
    on<UpdateProductEvent>(_updateItem);
    on<UploadImageEvent>(_uploadImage);
    on<DeleteImageEvent>(_deleteImage);
    on<DeleteEvent>(_deleteProduct);
  }

  _removePhoto(RemoveItemEvent event, Emitter<ItemsState> emit) {
    emit(RemoveItemState(i: event.i));
  }

  _addItem(ItemAddEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    List<MultipartFile> files = [];
    for (int i = 0; i < event.bytes.length; i++) {
      files.add(MultipartFile.fromBytes(event.bytes[i],
          filename: "$i", contentType: MediaType.parse("image/jpeg")));
    }
    ResponseModel res = await ItemsCore.addItem(event.itemModel, files);
    if (res.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: res.errorCode ?? ""));
    }
  }

  _getItemsCriteria(ItemGetEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    ResponseModel response = await ItemsCore.getItems(
        event.skip, event.limit, event.name, event.low, event.high);
    if (response.success) {
      GetItemsModel data =
          GetItemsModel.fromJson(jsonDecode(response.res!.data));
      emit(GetItemSuccess(data: data));
    } else {
      emit(ItemsFail(code: response.errorCode!));
    }
  }

  _getItemDetails(ItemGetDetails event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    ResponseModel res = await ItemsCore.getItemDetails(event.id);
    if (res.success) {
      ItemDetailsModel data =
          ItemDetailsModel.fromJson(jsonDecode(res.res!.data));
      emit(GetItemDetailsSuccess(itemDetailsModel: data));
    } else {
      emit(ItemsFail(code: res.errorCode ?? ""));
    }
  }

  _updateItem(UpdateProductEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    ResponseModel res = await ItemsCore.updateItem(event.itemDetailsModel);
    if (res.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: res.errorCode ?? ""));
    }
  }

  _uploadImage(UploadImageEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    MultipartFile multipartFile = MultipartFile.fromBytes(event.bytes,
        filename: "1", contentType: MediaType.parse("image/jpeg"));
    ResponseModel res = await ItemsCore.uploadImage(event.id, multipartFile);
    if (res.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: res.errorCode ?? ""));
    }
  }

  _deleteImage(DeleteImageEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    ResponseModel responseModel =
        await ItemsCore.deleteImage(event.id, event.itemId);
    if (responseModel.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: responseModel.errorCode ?? ""));
    }
  }

  _deleteProduct(DeleteEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    ResponseModel responseModel = await ItemsCore.deleteProduct(event.id);
    if (responseModel.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: responseModel.errorCode ?? ""));
    }
  }
}
