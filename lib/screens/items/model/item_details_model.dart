/// data : {"id":"631c954fa687434692039c33","name":"Mouse","description":"Iure ipsum quia pariatur explicabo et culpa officiis.","price":3000,"discount":0.25,"isActive":true,"isSpecial":false,"images":["631c99f4a687434692039d3f","631c9972a687434692039d11"],"createdAt":"2022-09-10T13:46:55.137Z","updatedAt":"2022-09-10T14:10:39.380Z"}

class ItemDetailsModel {
  ItemDetailsModel({
      DetailsData? data,}){
    _data = data;
}

  ItemDetailsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? DetailsData.fromJson(json['data']) : null;
  }
  DetailsData? _data;
ItemDetailsModel copyWith({  DetailsData? data,
}) => ItemDetailsModel(  data: data ?? _data,
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

/// id : "631c954fa687434692039c33"
/// name : "Mouse"
/// description : "Iure ipsum quia pariatur explicabo et culpa officiis."
/// price : 3000
/// discount : 0.25
/// isActive : true
/// isSpecial : false
/// images : ["631c99f4a687434692039d3f","631c9972a687434692039d11"]
/// createdAt : "2022-09-10T13:46:55.137Z"
/// updatedAt : "2022-09-10T14:10:39.380Z"

class DetailsData {
  DetailsData({
      String? id, 
      String? name, 
      String? description, 
      num? price, 
      num? discount, 
      bool? isActive, 
      bool? isSpecial, 
      List<String>? images, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _description = description;
    _price = price;
    _discount = discount;
    _isActive = isActive;
    _isSpecial = isSpecial;
    _images = images;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  DetailsData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _discount = json['discount'];
    _isActive = json['isActive'];
    _isSpecial = json['isSpecial'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _name;
  String? _description;
  num? _price;
  num? _discount;
  bool? _isActive;
  bool? _isSpecial;
  List<String>? _images;
  String? _createdAt;
  String? _updatedAt;
DetailsData copyWith({  String? id,
  String? name,
  String? description,
  num? price,
  num? discount,
  bool? isActive,
  bool? isSpecial,
  List<String>? images,
  String? createdAt,
  String? updatedAt,
}) => DetailsData(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  price: price ?? _price,
  discount: discount ?? _discount,
  isActive: isActive ?? _isActive,
  isSpecial: isSpecial ?? _isSpecial,
  images: images ?? _images,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get price => _price;
  num? get discount => _discount;
  bool? get isActive => _isActive;
  bool? get isSpecial => _isSpecial;
  List<String>? get images => _images;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['discount'] = _discount;
    map['isActive'] = _isActive;
    map['isSpecial'] = _isSpecial;
    map['images'] = _images;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}