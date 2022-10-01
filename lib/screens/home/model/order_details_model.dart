/// data : {"id":"6336ee61d5ea0d23b2d09ccd","type":"Cash","statuses":[{"status":"Pending","at":"2022-09-30T13:25:53.768Z"},{"status":"Done","at":"2022-09-30T13:25:53.768Z"}],"discount":0,"subTotal":3000,"totalPrice":3000,"products":[{"id":"632b968ada6d9ddb17b48173","name":"Chips","qty":3,"price":1000,"warrantyExpiresAt":"2022-12-30T13:25:53.768Z"}],"createdAt":"2022-09-30T13:25:53.769Z","updatedAt":"2022-09-30T13:25:53.769Z"}

class OrderDetailsModel {
  OrderDetailsModel({
    OrderDetailsData? data,
  }) {
    _data = data;
  }

  OrderDetailsModel.fromJson(dynamic json) {
    _data =
        json['data'] != null ? OrderDetailsData.fromJson(json['data']) : null;
  }
  OrderDetailsData? _data;
  OrderDetailsModel copyWith({
    OrderDetailsData? data,
  }) =>
      OrderDetailsModel(
        data: data ?? _data,
      );
  OrderDetailsData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : "6336ee61d5ea0d23b2d09ccd"
/// type : "Cash"
/// statuses : [{"status":"Pending","at":"2022-09-30T13:25:53.768Z"},{"status":"Done","at":"2022-09-30T13:25:53.768Z"}]
/// discount : 0
/// subTotal : 3000
/// totalPrice : 3000
/// products : [{"id":"632b968ada6d9ddb17b48173","name":"Chips","qty":3,"price":1000,"warrantyExpiresAt":"2022-12-30T13:25:53.768Z"}]
/// createdAt : "2022-09-30T13:25:53.769Z"
/// updatedAt : "2022-09-30T13:25:53.769Z"

class OrderDetailsData {
  OrderDetailsData({
    String? id,
    String? type,
    List<Statuses>? statuses,
    num? discount,
    num? subTotal,
    num? totalPrice,
    List<Products>? products,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _type = type;
    _statuses = statuses;
    _discount = discount;
    _subTotal = subTotal;
    _totalPrice = totalPrice;
    _products = products;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  OrderDetailsData.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    if (json['statuses'] != null) {
      _statuses = [];
      json['statuses'].forEach((v) {
        _statuses?.add(Statuses.fromJson(v));
      });
    }
    _discount = json['discount'];
    _subTotal = json['subTotal'];
    _totalPrice = json['totalPrice'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _type;
  List<Statuses>? _statuses;
  num? _discount;
  num? _subTotal;
  num? _totalPrice;
  List<Products>? _products;
  String? _createdAt;
  String? _updatedAt;
  OrderDetailsData copyWith({
    String? id,
    String? type,
    List<Statuses>? statuses,
    num? discount,
    num? subTotal,
    num? totalPrice,
    List<Products>? products,
    String? createdAt,
    String? updatedAt,
  }) =>
      OrderDetailsData(
        id: id ?? _id,
        type: type ?? _type,
        statuses: statuses ?? _statuses,
        discount: discount ?? _discount,
        subTotal: subTotal ?? _subTotal,
        totalPrice: totalPrice ?? _totalPrice,
        products: products ?? _products,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get type => _type;
  List<Statuses>? get statuses => _statuses;
  num? get discount => _discount;
  num? get subTotal => _subTotal;
  num? get totalPrice => _totalPrice;
  List<Products>? get products => _products;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    if (_statuses != null) {
      map['statuses'] = _statuses?.map((v) => v.toJson()).toList();
    }
    map['discount'] = _discount;
    map['subTotal'] = _subTotal;
    map['totalPrice'] = _totalPrice;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

/// id : "632b968ada6d9ddb17b48173"
/// name : "Chips"
/// qty : 3
/// price : 1000
/// warrantyExpiresAt : "2022-12-30T13:25:53.768Z"

class Products {
  Products({
    String? id,
    String? name,
    num? qty,
    num? price,
    String? warrantyExpiresAt,
  }) {
    _id = id;
    _name = name;
    _qty = qty;
    _price = price;
    _warrantyExpiresAt = warrantyExpiresAt;
  }

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _qty = json['qty'];
    _price = json['price'];
    _warrantyExpiresAt = json['warrantyExpiresAt'];
  }
  String? _id;
  String? _name;
  num? _qty;
  num? _price;
  String? _warrantyExpiresAt;
  Products copyWith({
    String? id,
    String? name,
    num? qty,
    num? price,
    String? warrantyExpiresAt,
  }) =>
      Products(
        id: id ?? _id,
        name: name ?? _name,
        qty: qty ?? _qty,
        price: price ?? _price,
        warrantyExpiresAt: warrantyExpiresAt ?? _warrantyExpiresAt,
      );
  String? get id => _id;
  String? get name => _name;
  num? get qty => _qty;
  num? get price => _price;
  String? get warrantyExpiresAt => _warrantyExpiresAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['qty'] = _qty;
    map['price'] = _price;
    map['warrantyExpiresAt'] = _warrantyExpiresAt;
    return map;
  }
}

/// status : "Pending"
/// at : "2022-09-30T13:25:53.768Z"

class Statuses {
  Statuses({
    String? status,
    String? at,
  }) {
    _status = status;
    _at = at;
  }

  Statuses.fromJson(dynamic json) {
    _status = json['status'];
    _at = json['at'];
  }
  String? _status;
  String? _at;
  Statuses copyWith({
    String? status,
    String? at,
  }) =>
      Statuses(
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
