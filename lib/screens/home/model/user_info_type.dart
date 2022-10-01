/// totalRecords : 3
/// data : [{"type":"Customer","fullName":"Shelley Hoeger","phone":"+7545939744","email":"Nedra_Lindgren96@gmail.com","isActive":true,"isVerified":{"email":false,"phone":false},"subscription":{"id":"000000040000000000000002","name":"اشتراك لمدة 3 أشهر","expiresAt":"2022-12-30T13:33:45.518Z"},"id":"632c77ffe918a82087941a57"},{"type":"Customer","fullName":"Dr. Lila Rogahn","phone":"+4052018035","email":"Albert_Mills62@gmail.com","isActive":true,"isVerified":{"email":false,"phone":false},"subscription":{"id":"000000040000000000000002","name":"اشتراك لمدة 3 أشهر","expiresAt":"2022-12-30T13:36:13.974Z"},"id":"632c77ffe918a82087941a53"},{"type":"Customer","fullName":"Dr. Tiffany O'Kon","phone":"+966123456789","email":"Jonas98@example.org","isActive":true,"isVerified":{"email":false,"phone":false},"subscription":{"id":"000000040000000000000000","name":"jjjjjjj","expiresAt":"2022-12-29T15:29:11.553Z"},"id":"6325c58f895c8c1c976ccecf"}]

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
/// fullName : "Shelley Hoeger"
/// phone : "+7545939744"
/// email : "Nedra_Lindgren96@gmail.com"
/// isActive : true
/// isVerified : {"email":false,"phone":false}
/// subscription : {"id":"000000040000000000000002","name":"اشتراك لمدة 3 أشهر","expiresAt":"2022-12-30T13:33:45.518Z"}
/// id : "632c77ffe918a82087941a57"

class UserMainData {
  UserMainData({
    String? type,
    String? fullName,
    String? phone,
    String? email,
    bool? isActive,
    IsVerified? isVerified,
    Subscription? subscription,
    String? id,
  }) {
    _type = type;
    _fullName = fullName;
    _phone = phone;
    _email = email;
    _isActive = isActive;
    _isVerified = isVerified;
    _subscription = subscription;
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
    _subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    _id = json['id'];
  }
  String? _type;
  String? _fullName;
  String? _phone;
  String? _email;
  bool? _isActive;
  IsVerified? _isVerified;
  Subscription? _subscription;
  String? _id;
  UserMainData copyWith({
    String? type,
    String? fullName,
    String? phone,
    String? email,
    bool? isActive,
    IsVerified? isVerified,
    Subscription? subscription,
    String? id,
  }) =>
      UserMainData(
        type: type ?? _type,
        fullName: fullName ?? _fullName,
        phone: phone ?? _phone,
        email: email ?? _email,
        isActive: isActive ?? _isActive,
        isVerified: isVerified ?? _isVerified,
        subscription: subscription ?? _subscription,
        id: id ?? _id,
      );
  String? get type => _type;
  String? get fullName => _fullName;
  String? get phone => _phone;
  String? get email => _email;
  bool? get isActive => _isActive;
  IsVerified? get isVerified => _isVerified;
  Subscription? get subscription => _subscription;
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
    if (_subscription != null) {
      map['subscription'] = _subscription?.toJson();
    }
    map['id'] = _id;
    return map;
  }
}

/// id : "000000040000000000000002"
/// name : "اشتراك لمدة 3 أشهر"
/// expiresAt : "2022-12-30T13:33:45.518Z"

class Subscription {
  Subscription({
    String? id,
    String? name,
    String? expiresAt,
  }) {
    _id = id;
    _name = name;
    _expiresAt = expiresAt;
  }

  Subscription.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _expiresAt = json['expiresAt'];
  }
  String? _id;
  String? _name;
  String? _expiresAt;
  Subscription copyWith({
    String? id,
    String? name,
    String? expiresAt,
  }) =>
      Subscription(
        id: id ?? _id,
        name: name ?? _name,
        expiresAt: expiresAt ?? _expiresAt,
      );
  String? get id => _id;
  String? get name => _name;
  String? get expiresAt => _expiresAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['expiresAt'] = _expiresAt;
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
