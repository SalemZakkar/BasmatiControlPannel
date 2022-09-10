/// totalRecords : 3
/// data : [{"id":"000000030000000000000002","name":"كشف","description":"Molestiae sed quas pariatur quisquam voluptatem fuga vel consectetur possimus.","price":300,"discount":0.05,"isActive":false,"image":"000000010000000300000005"},{"id":"000000030000000000000001","name":"تقويم أسنان","description":"Molestiae sed quas pariatur quisquam voluptatem fuga vel consectetur possimus.","price":1200,"discount":0.3,"isActive":true,"image":"000000010000000300000003"},{"id":"000000030000000000000000","name":"ابتسامة هولود","description":"Totam quod reprehenderit voluptatibus illo velit qui.","price":1000,"discount":0.25,"isActive":true,"image":"000000010000000300000000"}]

class GetItemsModel {
  GetItemsModel({
      num? totalRecords, 
      List<ItemData>? data,}){
    _totalRecords = totalRecords;
    _data = data;
}

  GetItemsModel.fromJson(dynamic json) {
    _totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ItemData.fromJson(v));
      });
    }
  }
  num? _totalRecords;
  List<ItemData>? _data;
GetItemsModel copyWith({  num? totalRecords,
  List<ItemData>? data,
}) => GetItemsModel(  totalRecords: totalRecords ?? _totalRecords,
  data: data ?? _data,
);
  num? get totalRecords => _totalRecords;
  List<ItemData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRecords'] = _totalRecords;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "000000030000000000000002"
/// name : "كشف"
/// description : "Molestiae sed quas pariatur quisquam voluptatem fuga vel consectetur possimus."
/// price : 300
/// discount : 0.05
/// isActive : false
/// image : "000000010000000300000005"

class ItemData {
  ItemData({
      String? id, 
      String? name, 
      String? description, 
      num? price, 
      num? discount, 
      bool? isActive, 
      String? image,}){
    _id = id;
    _name = name;
    _description = description;
    _price = price;
    _discount = discount;
    _isActive = isActive;
    _image = image;
}

  ItemData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _discount = json['discount'];
    _isActive = json['isActive'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _description;
  num? _price;
  num? _discount;
  bool? _isActive;
  String? _image;
ItemData copyWith({  String? id,
  String? name,
  String? description,
  num? price,
  num? discount,
  bool? isActive,
  String? image,
}) => ItemData(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  price: price ?? _price,
  discount: discount ?? _discount,
  isActive: isActive ?? _isActive,
  image: image ?? _image,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get price => _price;
  num? get discount => _discount;
  bool? get isActive => _isActive;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['discount'] = _discount;
    map['isActive'] = _isActive;
    map['image'] = _image;
    return map;
  }

}