/// data : {"id":"631de314102b12a43ac1c081","warranty":{"value":1,"unit":"month"},"name":"Chicken","description":"Est molestiae eum hic quia facere fugit.","fullPrice":1500,"price":300,"isActive":true,"isSpecial":true,"images":["631de314102b12a43ac1c07f"],"createdAt":"2022-09-11T13:31:00.549Z","updatedAt":"2022-09-11T13:31:00.549Z"}

class ItemDetailsModel {
  ItemDetailsModel({
    DetailsData? data,
  }) {
    _data = data;
  }

  ItemDetailsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? DetailsData.fromJson(json['data']) : null;
  }
  DetailsData? _data;
  ItemDetailsModel copyWith({
    DetailsData? data,
  }) =>
      ItemDetailsModel(
        data: data ?? _data,
      );
  DetailsData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : "631de314102b12a43ac1c081"
/// warranty : {"value":1,"unit":"month"}
/// name : "Chicken"
/// description : "Est molestiae eum hic quia facere fugit."
/// fullPrice : 1500
/// price : 300
/// isActive : true
/// isSpecial : true
/// images : ["631de314102b12a43ac1c07f"]
/// createdAt : "2022-09-11T13:31:00.549Z"
/// updatedAt : "2022-09-11T13:31:00.549Z"

class DetailsData {
  DetailsData({
    String? id,
    Warranty? warranty,
    String? name,
    String? description,
    num? fullPrice,
    num? price,
    bool? isActive,
    bool? isSpecial,
    List<String>? images,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _warranty = warranty;
    _name = name;
    _description = description;
    _fullPrice = fullPrice;
    _price = price;
    _isActive = isActive;
    _isSpecial = isSpecial;
    _images = images;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  DetailsData.fromJson(dynamic json) {
    _id = json['id'];
    _warranty =
        json['warranty'] != null ? Warranty.fromJson(json['warranty']) : null;
    _name = json['name'];
    _description = json['description'];
    _fullPrice = json['fullPrice'];
    _price = json['price'];
    _isActive = json['isActive'];
    _isSpecial = json['isSpecial'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  Warranty? _warranty;
  String? _name;
  String? _description;
  num? _fullPrice;
  num? _price;
  bool? _isActive;
  bool? _isSpecial;
  List<String>? _images;
  String? _createdAt;
  String? _updatedAt;
  DetailsData copyWith({
    String? id,
    Warranty? warranty,
    String? name,
    String? description,
    num? fullPrice,
    num? price,
    bool? isActive,
    bool? isSpecial,
    List<String>? images,
    String? createdAt,
    String? updatedAt,
  }) =>
      DetailsData(
        id: id ?? _id,
        warranty: warranty ?? _warranty,
        name: name ?? _name,
        description: description ?? _description,
        fullPrice: fullPrice ?? _fullPrice,
        price: price ?? _price,
        isActive: isActive ?? _isActive,
        isSpecial: isSpecial ?? _isSpecial,
        images: images ?? _images,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  Warranty? get warranty => _warranty;
  String? get name => _name;
  String? get description => _description;
  num? get fullPrice => _fullPrice;
  num? get price => _price;
  bool? get isActive => _isActive;
  bool? get isSpecial => _isSpecial;
  List<String>? get images => _images;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_warranty != null) {
      map['warranty'] = _warranty?.toJson();
    }
    map['name'] = _name;
    map['description'] = _description;
    map['fullPrice'] = _fullPrice;
    map['price'] = _price;
    map['isActive'] = _isActive;
    map['isSpecial'] = _isSpecial;
    map['images'] = _images;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

/// value : 1
/// unit : "month"

class Warranty {
  Warranty({
    num? value,
    String? unit,
  }) {
    _value = value;
    _unit = unit;
  }

  Warranty.fromJson(dynamic json) {
    _value = json['value'];
    _unit = json['unit'];
  }
  num? _value;
  String? _unit;
  Warranty copyWith({
    num? value,
    String? unit,
  }) =>
      Warranty(
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
