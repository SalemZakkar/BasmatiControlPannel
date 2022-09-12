/// totalRecords : 5
/// data : [{"id":"631de314102b12a43ac1c081","warranty":{"value":1,"unit":"month"},"name":"Chicken","description":"Est molestiae eum hic quia facere fugit.","fullPrice":1500,"price":300,"isActive":true,"isSpecial":true,"image":"631de314102b12a43ac1c07f"},{"id":"631de254102b12a43ac1c06f","warranty":{"value":1,"unit":"month"},"name":"Shoes","description":"Corrupti ullam et officia et non.","fullPrice":1500,"price":1000,"isActive":true,"isSpecial":true,"image":"631de254102b12a43ac1c06d"},{"id":"000000030000000000000002","name":"كشف","description":"Molestiae sed quas pariatur quisquam voluptatem fuga vel consectetur possimus.","fullPrice":300,"price":50,"isActive":false,"isSpecial":false,"image":"000000010000000300000005"},{"id":"000000030000000000000001","warranty":{"value":1,"unit":"month"},"name":"تقويم أسنان","description":"Molestiae sed quas pariatur quisquam voluptatem fuga vel consectetur possimus.","fullPrice":1200,"price":1000,"isActive":true,"isSpecial":false,"image":"000000010000000300000003"},{"id":"000000030000000000000000","warranty":{"value":1,"unit":"month"},"name":"ابتسامة هولود","description":"Totam quod reprehenderit voluptatibus illo velit qui.","fullPrice":1000,"price":800,"isActive":true,"isSpecial":false,"image":"000000010000000300000000"}]

class GetItemsModel {
  GetItemsModel({
    num? totalRecords,
    List<ItemData>? data,
  }) {
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
  GetItemsModel copyWith({
    num? totalRecords,
    List<ItemData>? data,
  }) =>
      GetItemsModel(
        totalRecords: totalRecords ?? _totalRecords,
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

/// id : "631de314102b12a43ac1c081"
/// warranty : {"value":1,"unit":"month"}
/// name : "Chicken"
/// description : "Est molestiae eum hic quia facere fugit."
/// fullPrice : 1500
/// price : 300
/// isActive : true
/// isSpecial : true
/// image : "631de314102b12a43ac1c07f"

class ItemData {
  ItemData({
    String? id,
    Warranty? warranty,
    String? name,
    String? description,
    num? fullPrice,
    num? price,
    bool? isActive,
    bool? isSpecial,
    String? image,
  }) {
    _id = id;
    _warranty = warranty;
    _name = name;
    _description = description;
    _fullPrice = fullPrice;
    _price = price;
    _isActive = isActive;
    _isSpecial = isSpecial;
    _image = image;
  }

  ItemData.fromJson(dynamic json) {
    _id = json['id'];
    _warranty =
        json['warranty'] != null ? Warranty.fromJson(json['warranty']) : null;
    _name = json['name'];
    _description = json['description'];
    _fullPrice = json['fullPrice'];
    _price = json['price'];
    _isActive = json['isActive'];
    _isSpecial = json['isSpecial'];
    _image = json['image'];
  }
  String? _id;
  Warranty? _warranty;
  String? _name;
  String? _description;
  num? _fullPrice;
  num? _price;
  bool? _isActive;
  bool? _isSpecial;
  String? _image;
  ItemData copyWith({
    String? id,
    Warranty? warranty,
    String? name,
    String? description,
    num? fullPrice,
    num? price,
    bool? isActive,
    bool? isSpecial,
    String? image,
  }) =>
      ItemData(
        id: id ?? _id,
        warranty: warranty ?? _warranty,
        name: name ?? _name,
        description: description ?? _description,
        fullPrice: fullPrice ?? _fullPrice,
        price: price ?? _price,
        isActive: isActive ?? _isActive,
        isSpecial: isSpecial ?? _isSpecial,
        image: image ?? _image,
      );
  String? get id => _id;
  Warranty? get warranty => _warranty;
  String? get name => _name;
  String? get description => _description;
  num? get fullPrice => _fullPrice;
  num? get price => _price;
  bool? get isActive => _isActive;
  bool? get isSpecial => _isSpecial;
  String? get image => _image;

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
    map['image'] = _image;
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
