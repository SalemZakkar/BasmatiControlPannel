/// totalRecords : 3
/// data : [{"id":"000000040000000000000002","duration":{"value":3,"unit":"month"},"name":"اشتراك لمدة 3 أشهر","description":"Totam quod reprehenderit voluptatibus illo velit qui.","price":350,"discount":0,"isActive":true},{"id":"000000040000000000000001","duration":{"value":1,"unit":"month"},"name":"اشتراك لمدة شهر","description":"Totam quod reprehenderit voluptatibus illo velit qui.","price":200,"discount":0,"isActive":true},{"id":"000000040000000000000000","duration":{"value":15,"unit":"day"},"name":"اشتراك لمدة 15 يوم","description":"Totam quod reprehenderit voluptatibus illo velit qui.","price":100,"discount":0,"isActive":true}]

class SubscriptionModel {
  SubscriptionModel({
    num? totalRecords,
    List<SubscriptionData>? data,
  }) {
    _totalRecords = totalRecords;
    _data = data;
  }

  SubscriptionModel.fromJson(dynamic json) {
    _totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SubscriptionData.fromJson(v));
      });
    }
  }
  num? _totalRecords;
  List<SubscriptionData>? _data;
  SubscriptionModel copyWith({
    num? totalRecords,
    List<SubscriptionData>? data,
  }) =>
      SubscriptionModel(
        totalRecords: totalRecords ?? _totalRecords,
        data: data ?? _data,
      );
  num? get totalRecords => _totalRecords;
  List<SubscriptionData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRecords'] = _totalRecords;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "000000040000000000000002"
/// duration : {"value":3,"unit":"month"}
/// name : "اشتراك لمدة 3 أشهر"
/// description : "Totam quod reprehenderit voluptatibus illo velit qui."
/// price : 350
/// discount : 0
/// isActive : true

class SubscriptionData {
  SubscriptionData({
    String? id,
    SubDuration? duration,
    String? name,
    String? description,
    num? price,
    num? discount,
    bool? isActive,
  }) {
    _id = id;
    _duration = duration;
    _name = name;
    _description = description;
    _price = price;
    _discount = discount;
    _isActive = isActive;
  }

  SubscriptionData.fromJson(dynamic json) {
    _id = json['id'];
    _duration = json['duration'] != null
        ? SubDuration.fromJson(json['duration'])
        : null;
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _discount = json['discount'];
    _isActive = json['isActive'];
  }
  String? _id;
  SubDuration? _duration;
  String? _name;
  String? _description;
  num? _price;
  num? _discount;
  bool? _isActive;
  SubscriptionData copyWith({
    String? id,
    SubDuration? duration,
    String? name,
    String? description,
    num? price,
    num? discount,
    bool? isActive,
  }) =>
      SubscriptionData(
        id: id ?? _id,
        duration: duration ?? _duration,
        name: name ?? _name,
        description: description ?? _description,
        price: price ?? _price,
        discount: discount ?? _discount,
        isActive: isActive ?? _isActive,
      );
  String? get id => _id;
  SubDuration? get duration => _duration;
  String? get name => _name;
  String? get description => _description;
  num? get price => _price;
  num? get discount => _discount;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_duration != null) {
      map['duration'] = _duration?.toJson();
    }
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['discount'] = _discount;
    map['isActive'] = _isActive;
    return map;
  }
}

/// value : 3
/// unit : "month"

class SubDuration {
  SubDuration({
    num? value,
    String? unit,
  }) {
    _value = value;
    _unit = unit;
  }

  SubDuration.fromJson(dynamic json) {
    _value = json['value'];
    _unit = json['unit'];
  }
  num? _value;
  String? _unit;
  SubDuration copyWith({
    num? value,
    String? unit,
  }) =>
      SubDuration(
        value: value ?? _value,
        unit: unit ?? _unit,
      );
  num? get value => _value;
  String? get unit => _unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['unit'] = _unit;
    return map;
  }
}
