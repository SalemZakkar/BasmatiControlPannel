/// totalRecords : 20
/// data : [{"id":"6335b4a0d5ea0d23b2d09c55","totalPrice":43956,"createdAt":"2022-09-29T15:07:12.620Z","productsCount":1,"status":{"status":"Done","at":"2022-09-29T15:07:12.616Z"}},{"id":"6335b43ad5ea0d23b2d09c49","totalPrice":43956,"createdAt":"2022-09-29T15:05:35.772Z","productsCount":1,"status":{"at":"2022-09-29T15:05:30.618Z","status":"Pending payment"}},{"id":"6335b3ced5ea0d23b2d09c3a","totalPrice":1332,"createdAt":"2022-09-29T15:03:47.814Z","productsCount":1,"status":{"at":"2022-09-29T15:03:42.612Z","status":"Pending payment"}},{"id":"632c8161e918a82087941ce8","totalPrice":576,"createdAt":"2022-09-22T15:38:14.744Z","productsCount":2,"status":{"at":"2022-09-22T15:38:09.646Z","status":"Pending payment"}},{"id":"632c814fe918a82087941cdf","totalPrice":576,"createdAt":"2022-09-22T15:37:56.574Z","productsCount":2,"status":{"at":"2022-09-22T15:37:51.437Z","status":"Pending payment"}},{"id":"632c8111e918a82087941cd6","totalPrice":576,"createdAt":"2022-09-22T15:36:54.119Z","productsCount":2,"status":{"at":"2022-09-22T15:36:49.010Z","status":"Pending payment"}},{"id":"632c80e1e918a82087941cd1","totalPrice":576,"createdAt":"2022-09-22T15:36:06.282Z","productsCount":2,"status":{"at":"2022-09-22T15:36:01.145Z","status":"Pending payment"}},{"id":"632c80a5e918a82087941cc1","totalPrice":576,"createdAt":"2022-09-22T15:35:06.578Z","productsCount":2,"status":{"at":"2022-09-22T15:35:01.406Z","status":"Pending payment"}},{"id":"632c7fa2e918a82087941c9a","totalPrice":576,"createdAt":"2022-09-22T15:30:47.572Z","productsCount":2,"status":{"at":"2022-09-22T15:30:42.473Z","status":"Pending payment"}},{"id":"632c7f80e918a82087941c8f","totalPrice":576,"createdAt":"2022-09-22T15:30:14.097Z","productsCount":2,"status":{"at":"2022-09-22T15:30:08.908Z","status":"Pending payment"}}]

class OrderLogsModel {
  OrderLogsModel({
    num? totalRecords,
    List<OrderLogData>? data,
  }) {
    _totalRecords = totalRecords;
    _data = data;
  }

  OrderLogsModel.fromJson(dynamic json) {
    _totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(OrderLogData.fromJson(v));
      });
    }
  }
  num? _totalRecords;
  List<OrderLogData>? _data;
  OrderLogsModel copyWith({
    num? totalRecords,
    List<OrderLogData>? data,
  }) =>
      OrderLogsModel(
        totalRecords: totalRecords ?? _totalRecords,
        data: data ?? _data,
      );
  num? get totalRecords => _totalRecords;
  List<OrderLogData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRecords'] = _totalRecords;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "6335b4a0d5ea0d23b2d09c55"
/// totalPrice : 43956
/// createdAt : "2022-09-29T15:07:12.620Z"
/// productsCount : 1
/// status : {"status":"Done","at":"2022-09-29T15:07:12.616Z"}

class OrderLogData {
  OrderLogData({
    String? id,
    num? totalPrice,
    String? createdAt,
    num? productsCount,
    Status? status,
  }) {
    _id = id;
    _totalPrice = totalPrice;
    _createdAt = createdAt;
    _productsCount = productsCount;
    _status = status;
  }

  OrderLogData.fromJson(dynamic json) {
    _id = json['id'];
    _totalPrice = json['totalPrice'];
    _createdAt = json['createdAt'];
    _productsCount = json['productsCount'];
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }
  String? _id;
  num? _totalPrice;
  String? _createdAt;
  num? _productsCount;
  Status? _status;
  OrderLogData copyWith({
    String? id,
    num? totalPrice,
    String? createdAt,
    num? productsCount,
    Status? status,
  }) =>
      OrderLogData(
        id: id ?? _id,
        totalPrice: totalPrice ?? _totalPrice,
        createdAt: createdAt ?? _createdAt,
        productsCount: productsCount ?? _productsCount,
        status: status ?? _status,
      );
  String? get id => _id;
  num? get totalPrice => _totalPrice;
  String? get createdAt => _createdAt;
  num? get productsCount => _productsCount;
  Status? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['totalPrice'] = _totalPrice;
    map['createdAt'] = _createdAt;
    map['productsCount'] = _productsCount;
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    return map;
  }
}

/// status : "Done"
/// at : "2022-09-29T15:07:12.616Z"

class Status {
  Status({
    String? status,
    String? at,
  }) {
    _status = status;
    _at = at;
  }

  Status.fromJson(dynamic json) {
    _status = json['status'];
    _at = json['at'];
  }
  String? _status;
  String? _at;
  Status copyWith({
    String? status,
    String? at,
  }) =>
      Status(
        status: status ?? _status,
        at: at ?? _at,
      );
  String? get status => _status;
  String? get at => _at;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['at'] = _at;
    return map;
  }
}
