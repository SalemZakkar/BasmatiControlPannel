import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/screens/items/model/get_items_model.dart';
import 'package:web_basmati/screens/items/model/item_details_model.dart';
import 'package:web_basmati/web_services/api_engine/api_engine.dart';
import 'package:web_basmati/web_services/api_engine/enum.dart';
import 'package:web_basmati/web_services/api_engine/response_model.dart';
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
    FormData formData = FormData.fromMap({
      "name": event.itemModel.data?.name!.trim(),
      "description": event.itemModel.data?.description!.trim(),
      "price": event.itemModel.data?.price,
      "images": files,
      "isActive": event.itemModel.data!.isActive,
      "isSpecial": event.itemModel.data!.isSpecial,
      "fullPrice": event.itemModel.data!.fullPrice
    });
    String token = await AuthStore.getToken() ?? "";
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: EndPoints.item,
        data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
    if (res.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: res.errorCode ?? ""));
    }
  }

  _getItemsCriteria(ItemGetEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    Map<String, dynamic> params = {};
    params.putIfAbsent("total", () => true);
    params.putIfAbsent("skip", () => event.skip);
    params.putIfAbsent("limit", () => event.limit);
    if (event.name != null) {
      params.putIfAbsent("name", () => event.name);
    }
    if (event.low != null) {
      params.putIfAbsent("price[gte]", () => event.low);
    }
    if (event.high != null) {
      params.putIfAbsent("price[lte]", () => event.high);
    }
    ResponseModel response = await ApiEngine.request(
        requestMethod: RequestMethod.get,
        path: EndPoints.item,
        data: params,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken() ?? ""}"
        }));
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
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.get,
        path: "${EndPoints.item}/${event.id}");
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
    Map<String, dynamic> form = {};
    form["name"] = event.itemDetailsModel.data?.name;
    form["description"] = event.itemDetailsModel.data?.description;
    form["images"] = event.itemDetailsModel.data?.images;
    form["price"] = event.itemDetailsModel.data?.price;
    form["isSpecial"] = event.itemDetailsModel.data?.isSpecial;
    form["isActive"] = event.itemDetailsModel.data?.isActive;
    form["fullPrice"] = event.itemDetailsModel.data?.fullPrice;
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.patch,
        path: "${EndPoints.item}/${event.itemDetailsModel.data!.id!}",
        data: form,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
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
    FormData formData = FormData.fromMap({
      "images": [multipartFile]
    });
    ResponseModel res = await ApiEngine.request(
        requestMethod: RequestMethod.post,
        path: "${EndPoints.item}/${event.id}/file",
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    if (res.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: res.errorCode ?? ""));
    }
  }

  _deleteImage(DeleteImageEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    ResponseModel responseModel = await ApiEngine.request(
        requestMethod: RequestMethod.delete,
        path: "${EndPoints.item}/${event.itemId}/${event.id}",
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    if (responseModel.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: responseModel.errorCode ?? ""));
    }
  }

  _deleteProduct(DeleteEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoading());
    ResponseModel responseModel = await ApiEngine.request(
        requestMethod: RequestMethod.delete,
        path: "${EndPoints.item}/${event.id}",
        options: Options(headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${await AuthStore.getToken()}"
        }));
    if (responseModel.success) {
      emit(ItemSuccess());
    } else {
      emit(ItemsFail(code: responseModel.errorCode ?? ""));
    }
  }
}

String xmlError = "XMLHttpRequest error.";
