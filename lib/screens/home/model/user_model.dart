/// data : {"id":"000000020000000000000003","type":"Customer","fullName":"Customer 1","phone":"+9660000000003","email":"Customer1@Basmati.com","avatar":"000000010000000200000003","isActive":true,"isVerified":{"email":false,"phone":false},"lastLogin":"2022-09-15T12:33:03.645Z","createdAt":"2022-09-15T12:33:03.724Z","updatedAt":"2022-09-22T14:15:21.892Z"}

class UserModel {
  UserModel({
    UserData? data,
  }) {
    _data = data;
  }

  UserModel.fromJson(dynamic json) {
    _data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  UserData? _data;
  UserModel copyWith({
    UserData? data,
  }) =>
      UserModel(
        data: data ?? _data,
      );
  UserData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : "000000020000000000000003"
/// type : "Customer"
/// fullName : "Customer 1"
/// phone : "+9660000000003"
/// email : "Customer1@Basmati.com"
/// avatar : "000000010000000200000003"
/// isActive : true
/// isVerified : {"email":false,"phone":false}
/// lastLogin : "2022-09-15T12:33:03.645Z"
/// createdAt : "2022-09-15T12:33:03.724Z"
/// updatedAt : "2022-09-22T14:15:21.892Z"

class UserData {
  UserData({
    String? id,
    String? type,
    String? fullName,
    String? phone,
    String? email,
    String? avatar,
    bool? isActive,
    IsVerified? isVerified,
    String? lastLogin,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _type = type;
    _fullName = fullName;
    _phone = phone;
    _email = email;
    _avatar = avatar;
    _isActive = isActive;
    _isVerified = isVerified;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  UserData.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _fullName = json['fullName'];
    _phone = json['phone'];
    _email = json['email'];
    _avatar = json['avatar'];
    _isActive = json['isActive'];
    _isVerified = json['isVerified'] != null
        ? IsVerified.fromJson(json['isVerified'])
        : null;
    _lastLogin = json['lastLogin'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _type;
  String? _fullName;
  String? _phone;
  String? _email;
  String? _avatar;
  bool? _isActive;
  IsVerified? _isVerified;
  String? _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  UserData copyWith({
    String? id,
    String? type,
    String? fullName,
    String? phone,
    String? email,
    String? avatar,
    bool? isActive,
    IsVerified? isVerified,
    String? lastLogin,
    String? createdAt,
    String? updatedAt,
  }) =>
      UserData(
        id: id ?? _id,
        type: type ?? _type,
        fullName: fullName ?? _fullName,
        phone: phone ?? _phone,
        email: email ?? _email,
        avatar: avatar ?? _avatar,
        isActive: isActive ?? _isActive,
        isVerified: isVerified ?? _isVerified,
        lastLogin: lastLogin ?? _lastLogin,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get type => _type;
  String? get fullName => _fullName;
  String? get phone => _phone;
  String? get email => _email;
  String? get avatar => _avatar;
  bool? get isActive => _isActive;
  IsVerified? get isVerified => _isVerified;
  String? get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['fullName'] = _fullName;
    map['phone'] = _phone;
    map['email'] = _email;
    map['avatar'] = _avatar;
    map['isActive'] = _isActive;
    if (_isVerified != null) {
      map['isVerified'] = _isVerified?.toJson();
    }
    map['lastLogin'] = _lastLogin;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
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
