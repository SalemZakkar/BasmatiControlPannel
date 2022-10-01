/// data : {"id":"6335b9c7d5ea0d23b2d09c73","type":"Cash","statuses":[{"status":"Pending","at":"2022-09-29T15:29:11.553Z"},{"status":"Done","at":"2022-09-29T15:29:11.553Z"}],"discount":0,"subTotal":400,"totalPrice":400,"subscription":{"id":"000000040000000000000000","name":"jjjjjjj","price":400,"expiresAt":"2022-12-29T15:29:11.553Z"},"createdAt":"2022-09-29T15:29:11.554Z","updatedAt":"2022-09-29T15:29:11.554Z"}

class SubscriptionDetailsModel {
  SubscriptionDetailsModel({
    SubscriptionDetailsData? data,
  }) {
    _data = data;
  }

  SubscriptionDetailsModel.fromJson(dynamic json) {
    _data = json['data'] != null
        ? SubscriptionDetailsData.fromJson(json['data'])
        : null;
  }
  SubscriptionDetailsData? _data;
  SubscriptionDetailsModel copyWith({
    SubscriptionDetailsData? data,
  }) =>
      SubscriptionDetailsModel(
        data: data ?? _data,
      );
  SubscriptionDetailsData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : "6335b9c7d5ea0d23b2d09c73"
/// type : "Cash"
/// statuses : [{"status":"Pending","at":"2022-09-29T15:29:11.553Z"},{"status":"Done","at":"2022-09-29T15:29:11.553Z"}]
/// discount : 0
/// subTotal : 400
/// totalPrice : 400
/// subscription : {"id":"000000040000000000000000","name":"jjjjjjj","price":400,"expiresAt":"2022-12-29T15:29:11.553Z"}
/// createdAt : "2022-09-29T15:29:11.554Z"
/// updatedAt : "2022-09-29T15:29:11.554Z"

class SubscriptionDetailsData {
  SubscriptionDetailsData({
    String? id,
    String? type,
    List<Statuses>? statuses,
    num? discount,
    num? subTotal,
    num? totalPrice,
    Subscription? subscription,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _type = type;
    _statuses = statuses;
    _discount = discount;
    _subTotal = subTotal;
    _totalPrice = totalPrice;
    _subscription = subscription;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  SubscriptionDetailsData.fromJson(dynamic json) {
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
    _subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _type;
  List<Statuses>? _statuses;
  num? _discount;
  num? _subTotal;
  num? _totalPrice;
  Subscription? _subscription;
  String? _createdAt;
  String? _updatedAt;
  SubscriptionDetailsData copyWith({
    String? id,
    String? type,
    List<Statuses>? statuses,
    num? discount,
    num? subTotal,
    num? totalPrice,
    Subscription? subscription,
    String? createdAt,
    String? updatedAt,
  }) =>
      SubscriptionDetailsData(
        id: id ?? _id,
        type: type ?? _type,
        statuses: statuses ?? _statuses,
        discount: discount ?? _discount,
        subTotal: subTotal ?? _subTotal,
        totalPrice: totalPrice ?? _totalPrice,
        subscription: subscription ?? _subscription,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get type => _type;
  List<Statuses>? get statuses => _statuses;
  num? get discount => _discount;
  num? get subTotal => _subTotal;
  num? get totalPrice => _totalPrice;
  Subscription? get subscription => _subscription;
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
    if (_subscription != null) {
      map['subscription'] = _subscription?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

/// id : "000000040000000000000000"
/// name : "jjjjjjj"
/// price : 400
/// expiresAt : "2022-12-29T15:29:11.553Z"

class Subscription {
  Subscription({
    String? id,
    String? name,
    num? price,
    String? expiresAt,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _expiresAt = expiresAt;
  }

  Subscription.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _expiresAt = json['expiresAt'];
  }
  String? _id;
  String? _name;
  num? _price;
  String? _expiresAt;
  Subscription copyWith({
    String? id,
    String? name,
    num? price,
    String? expiresAt,
  }) =>
      Subscription(
        id: id ?? _id,
        name: name ?? _name,
        price: price ?? _price,
        expiresAt: expiresAt ?? _expiresAt,
      );
  String? get id => _id;
  String? get name => _name;
  num? get price => _price;
  String? get expiresAt => _expiresAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['expiresAt'] = _expiresAt;
    return map;
  }
}

/// status : "Pending"
/// at : "2022-09-29T15:29:11.553Z"

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
