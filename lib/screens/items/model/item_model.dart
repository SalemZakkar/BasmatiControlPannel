/// data : {"id":"000000030000000000000000","name":"ابتسامة هولود","description":"Totam quod reprehenderit voluptatibus illo velit qui.","price":1000,"discount":0.25,"isActive":true,"images":["000000010000000300000000","000000010000000300000001","000000010000000300000002"],"createdAt":"2022-09-07T11:55:47.068Z","updatedAt":"2022-09-07T11:55:47.068Z"}

class ItemModel {
  ItemModel({
    Data? data,
  }) {
    _data = data;
  }

  ItemModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  ItemModel copyWith({
    Data? data,
  }) =>
      ItemModel(
        data: data ?? _data,
      );

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : "000000030000000000000000"
/// name : "ابتسامة هولود"
/// description : "Totam quod reprehenderit voluptatibus illo velit qui."
/// price : 1000
/// discount : 0.25
/// isActive : true
/// images : ["000000010000000300000000","000000010000000300000001","000000010000000300000002"]
/// createdAt : "2022-09-07T11:55:47.068Z"
/// updatedAt : "2022-09-07T11:55:47.068Z"

class Data {
  Data({
    String? id,
    String? name,
    String? description,
    num? price,
    num? discount,
    bool? isActive,
    List<String>? images,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _price = price;
    _discount = discount;
    _isActive = isActive;
    _images = images;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _discount = json['discount'];
    _isActive = json['isActive'];
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
  List<String>? _images;
  String? _createdAt;
  String? _updatedAt;

  Data copyWith({
    String? id,
    String? name,
    String? description,
    num? price,
    num? discount,
    bool? isActive,
    List<String>? images,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        price: price ?? _price,
        discount: discount ?? _discount,
        isActive: isActive ?? _isActive,
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
    map['images'] = _images;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
