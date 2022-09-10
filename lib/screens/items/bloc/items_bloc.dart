import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:web_basmati/core/items/item_core.dart';
import 'package:web_basmati/helper/error_data.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/screens/items/model/get_items_model.dart';
import 'package:web_basmati/screens/items/model/item_details_model.dart';
import 'package:web_basmati/screens/items/model/item_model.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

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
    on<ItemGetByName>(_getItemsByName);
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
    try {
      List<MultipartFile> files = [];
      for (int i = 0; i < event.bytes.length; i++) {
        files.add(MultipartFile.fromBytes(event.bytes[i],
            filename: "$i", contentType: MediaType.parse("image/jpeg")));
      }
      FormData formData = FormData.fromMap({
        "name": event.itemModel.data?.name!.trim(),
        "description": event.itemModel.data?.description!.trim(),
        "price": event.itemModel.data?.price,
        "images": files
      });
      if (event.itemModel.data?.discount != null) {
        double discount = event.itemModel.data!.discount!.toDouble() / 100;
        formData.fields.add(MapEntry("discount", discount.toString()));
      }

      String token = await AuthStore.getToken() ?? "";
      Response res = await myDio.post(EndPoints.item,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
              receiveTimeout: 0,
              sendTimeout: 0),
          data: formData);
      if (res.statusCode == 200 || res.statusCode == 201) {
        emit(ItemSuccess());
      } else {
        ErrorData errorData = ErrorData.fromJson(jsonDecode(res.data));
        emit(ItemsFail(code: errorData.code ?? "777"));
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout || e.type.index == 3 ) {
        emit(ItemsFail(code: "7"));
      } else {
        debugPrint(e.toString());
      }
    } catch (e) {
      emit(ItemsFail(code: "999"));
    }
  }

  _getItemsCriteria(ItemGetEvent event, Emitter<ItemsState> emit) async {
    try {
      emit(ItemsLoading());
      Response res = await ItemsCore.getItems(
          event.skip, event.limit, event.name, event.low, event.high);
      if (res.statusCode == 200 || res.statusCode == 201) {
        GetItemsModel data = GetItemsModel.fromJson(jsonDecode(res.data));
        emit(GetItemSuccess(data: data));
      } else {
        ErrorData error = jsonDecode(res.data);
        emit(ItemsFail(code: error.code ?? "999"));
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout || e.type.index == 3) {
        emit(ItemsFail(code: "7"));

      } else {
        emit(ItemsFail(code: "999"));
      }
    } catch (e) {
      emit(ItemsFail(code: "999"));
    }
  }

  _getItemsByName(ItemGetByName event, Emitter<ItemsState> emit) async {
    try {
      emit(ItemsLoading());
      Response res = await ItemsCore.getItemsByName(event.name);
      if (res.statusCode == 200 || res.statusCode == 201) {
        GetItemsModel data = GetItemsModel.fromJson(jsonDecode(res.data));
        emit(GetItemSuccess(data: data));
      } else {
        ErrorData error = jsonDecode(res.data);
        emit(ItemsFail(code: error.code ?? "999"));
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout || e.type.index == 3) {
        emit(ItemsFail(code: "7"));
      } else {
        emit(ItemsFail(code: "999"));
      }
    } catch (e) {
      emit(ItemsFail(code: "999"));
    }
  }

  _getItemDetails(ItemGetDetails event, Emitter<ItemsState> emit) async {
    try {
      emit(ItemsLoading());
      Response res = await ItemsCore.getItemDetails(event.id);
      if (res.statusCode == 200 || res.statusCode == 201) {
        emit(GetItemDetailsSuccess(
            itemDetailsModel: ItemDetailsModel.fromJson(jsonDecode(res.data))));
      } else {
        ErrorData errorData = ErrorData.fromJson(jsonDecode(res.data));
        emit(ItemsFail(code: errorData.code ?? "999"));
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout || e.type.index == 3 ) {
        emit(ItemsFail(code: "7"));
      } else {
        debugPrint(e.toString());
      }
    } catch (e) {
      emit(ItemsFail(code: "999"));
    }
  }

  _updateItem(UpdateProductEvent event, Emitter<ItemsState> emit) async {
    try {
      emit(ItemsLoading());
      Response res = await ItemsCore.updateItem(event.itemDetailsModel);
      if (res.statusCode == 200 || res.statusCode == 201) {
        emit(ItemSuccess());
      } else {
        ErrorData errorData = ErrorData.fromJson(jsonDecode(res.data));
        emit(ItemsFail(code: errorData.code ?? "999"));
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout || e.type.index == 3) {
        emit(ItemsFail(code: "7"));
      } else {
        emit(ItemsFail(code: "999"));
      }
    } catch (e) {
      emit(ItemsFail(code: "999"));
    }
  }

  _uploadImage(UploadImageEvent event, Emitter<ItemsState> emit) async {
    // print('\n\n\n\n\n\n\n\n\n\n\n-------------------------------->/ n');
    try {
      emit(ItemsLoading());
      MultipartFile multipartFile = MultipartFile.fromBytes(event.bytes,
          filename: "1", contentType: MediaType.parse("image/jpeg"));
      Response res = await ItemsCore.uploadImage(event.id, multipartFile);
      if (res.statusCode == 200 || res.statusCode == 201) {
        emit(ItemSuccess());
      } else {
        ErrorData errorData = ErrorData.fromJson(jsonDecode(res.data));
        emit(ItemsFail(code: errorData.code ?? "999"));
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout || e.type.index == 3) {
        emit(ItemsFail(code: "7"));
      } else {
        emit(ItemsFail(code: "999"));
      }
    } catch (e) {
      emit(ItemsFail(code: "999"));
    }
  }

  _deleteImage(DeleteImageEvent event, Emitter<ItemsState> emit) async {
    try {
      emit(ItemsLoading());
      Response res = await ItemsCore.deleteImage(event.id , event.itemId);
      if (res.statusCode == 200 || res.statusCode == 204) {
        emit(ItemSuccess());
      } else {
        ErrorData errorData = ErrorData.fromJson(jsonDecode(res.data));
        emit(ItemsFail(code: errorData.code ?? "999"));
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout || e.type.index == 3) {
        emit(ItemsFail(code: "7"));
      } else {
        emit(ItemsFail(code: "999"));
      }
    } catch (e) {
      emit(ItemsFail(code: "999"));
    }
  }
  _deleteProduct(DeleteEvent event , Emitter<ItemsState> emit) async
  {
    emit(ItemsLoading());
    try{
      Response res = await ItemsCore.deleteProduct(event.id);
      if(res.statusCode == 200 || res.statusCode ==201 || res.statusCode == 204){
        emit(ItemSuccess());
      }else{
        ErrorData errorData = ErrorData.fromJson(jsonDecode(res.data));
        emit(ItemsFail(code: errorData.code ?? "999"));
      }
    } on DioError catch (e) {
      if (e.error is SocketException || e.type == DioErrorType.connectTimeout || e.type.index == 3) {
        emit(ItemsFail(code: "7"));
      } else {
        emit(ItemsFail(code: "999"));
      }
    } catch (e) {
      emit(ItemsFail(code: "999"));
    }
  }
}
