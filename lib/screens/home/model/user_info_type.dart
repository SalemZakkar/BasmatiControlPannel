/// totalRecords : 7
/// data : [{"type":"Customer","fullName":"Miss Grace Little","phone":"+8867252878","email":"Eddie54@example.org","isActive":true,"isVerified":{"email":false,"phone":false},"id":"632ae4abda6d9ddb17b47ee2"},{"type":"Customer","fullName":"Dr. Tiffany O'Kon","phone":"+966123456789","email":"Jonas98@example.org","isActive":true,"isVerified":{"email":false,"phone":false},"id":"6325c58f895c8c1c976ccecf"},{"type":"Customer","fullName":"لللا لل اا","phone":"+501234566","isActive":true,"isVerified":{"email":false,"phone":false},"id":"6324b5c85247ad8198bcb427"},{"type":"Customer","fullName":"ااال للغ لققا","phone":"+9660000000004","email":"Customer2@Basmati.com","isActive":true,"isVerified":{"email":false,"phone":false},"id":"000000020000000000000004"},{"type":"Customer","fullName":"Customer 1","phone":"+9660000000003","email":"Customer1@Basmati.com","isActive":true,"isVerified":{"email":false,"phone":false},"id":"000000020000000000000003"},{"type":"Admin","fullName":"Admin 2","phone":"+9660000000002","email":"admin2@Basmati.com","isActive":true,"isVerified":{"email":false,"phone":false},"id":"000000020000000000000002"},{"type":"Admin","fullName":"Admin","phone":"+9660000000001","email":"admin1@Basmati.com","isActive":true,"isVerified":{"email":false,"phone":false},"id":"000000020000000000000001"}]

class UserInfoType {
  UserInfoType({
    num? totalRecords,
    List<UserMainData>? data,
  }) {
    _totalRecords = totalRecords;
    _data = data;
  }

  UserInfoType.fromJson(dynamic json) {
    _totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UserMainData.fromJson(v));
      });
    }
  }
  num? _totalRecords;
  List<UserMainData>? _data;
  UserInfoType copyWith({
    num? totalRecords,
    List<UserMainData>? data,
  }) =>
      UserInfoType(
        totalRecords: totalRecords ?? _totalRecords,
        data: data ?? _data,
      );
  num? get totalRecords => _totalRecords;
  List<UserMainData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRecords'] = _totalRecords;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : "Customer"
/// fullName : "Miss Grace Little"
/// phone : "+8867252878"
/// email : "Eddie54@example.org"
/// isActive : true
/// isVerified : {"email":false,"phone":false}
/// id : "632ae4abda6d9ddb17b47ee2"

class UserMainData {
  UserMainData({
    String? type,
    String? fullName,
    String? phone,
    String? email,
    bool? isActive,
    IsVerified? isVerified,
    String? id,
  }) {
    _type = type;
    _fullName = fullName;
    _phone = phone;
    _email = email;
    _isActive = isActive;
    _isVerified = isVerified;
    _id = id;
  }

  UserMainData.fromJson(dynamic json) {
    _type = json['type'];
    _fullName = json['fullName'];
    _phone = json['phone'];
    _email = json['email'];
    _isActive = json['isActive'];
    _isVerified = json['isVerified'] != null
        ? IsVerified.fromJson(json['isVerified'])
        : null;
    _id = json['id'];
  }
  String? _type;
  String? _fullName;
  String? _phone;
  String? _email;
  bool? _isActive;
  IsVerified? _isVerified;
  String? _id;
  UserMainData copyWith({
    String? type,
    String? fullName,
    String? phone,
    String? email,
    bool? isActive,
    IsVerified? isVerified,
    String? id,
  }) =>
      UserMainData(
        type: type ?? _type,
        fullName: fullName ?? _fullName,
        phone: phone ?? _phone,
        email: email ?? _email,
        isActive: isActive ?? _isActive,
        isVerified: isVerified ?? _isVerified,
        id: id ?? _id,
      );
  String? get type => _type;
  String? get fullName => _fullName;
  String? get phone => _phone;
  String? get email => _email;
  bool? get isActive => _isActive;
  IsVerified? get isVerified => _isVerified;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['fullName'] = _fullName;
    map['phone'] = _phone;
    map['email'] = _email;
    map['isActive'] = _isActive;
    if (_isVerified != null) {
      map['isVerified'] = _isVerified?.toJson();
    }
    map['id'] = _id;
    return map;
  }
}

/// email : false
/// phone : false

class IsVerified {
  IsVerified({
    bool? email,
    bool? phone,
  }) {
    _email = email;
    _phone = phone;
  }

  IsVerified.fromJson(dynamic json) {
    _email = json['email'];
    _phone = json['phone'];
  }
  bool? _email;
  bool? _phone;
  IsVerified copyWith({
    bool? email,
    bool? phone,
  }) =>
      IsVerified(
        email: email ?? _email,
        phone: phone ?? _phone,
      );
  bool? get email => _email;
  bool? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['phone'] = _phone;
    return map;
  }
}
