import 'dart:convert';

/// data : [{"type":"Admin","fullName":"Admin 2","phone":"+9660000000002","email":"admin2@Basmati.com","isActive":true,"isVerified":{"email":false,"phone":false},"id":"000000020000000000000002"},{"type":"Admin","fullName":"Admin","phone":"+9660000000001","email":"admin1@Basmati.com","isActive":true,"isVerified":{"email":false,"phone":false},"id":"000000020000000000000001"}]

UserInfoType userInfoTypeFromJson(String str) => UserInfoType.fromJson(json.decode(str));

String userInfoTypeToJson(UserInfoType data) => json.encode(data.toJson());

class UserInfoType {
  UserInfoType({
    List<Data>? data,
  }) {
    _data = data;
  }

  UserInfoType.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  List<Data>? _data;

  UserInfoType copyWith({
    List<Data>? data,
  }) =>
      UserInfoType(
        data: data ?? _data,
      );

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : "Admin"
/// fullName : "Admin 2"
/// phone : "+9660000000002"
/// email : "admin2@Basmati.com"
/// isActive : true
/// isVerified : {"email":false,"phone":false}
/// id : "000000020000000000000002"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
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

  Data.fromJson(dynamic json) {
    _type = json['type'];
    _fullName = json['fullName'];
    _phone = json['phone'];
    _email = json['email'];
    _isActive = json['isActive'];
    _isVerified =
        json['isVerified'] != null ? IsVerified.fromJson(json['isVerified']) : null;
    _id = json['id'];
  }

  String? _type;
  String? _fullName;
  String? _phone;
  String? _email;
  bool? _isActive;
  IsVerified? _isVerified;
  String? _id;

  Data copyWith({
    String? type,
    String? fullName,
    String? phone,
    String? email,
    bool? isActive,
    IsVerified? isVerified,
    String? id,
  }) =>
      Data(
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

IsVerified isVerifiedFromJson(String str) => IsVerified.fromJson(json.decode(str));

String isVerifiedToJson(IsVerified data) => json.encode(data.toJson());

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
