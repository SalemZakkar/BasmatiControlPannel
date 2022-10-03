/// data : {"id":"000000020000000000000003","type":"Customer","fullName":"Customer 1","phone":"+9660000000003","email":"Customer1@Basmati.com","avatar":"000000010000000200000003","isActive":true,"isVerified":{"email":false,"phone":false},"lastLogin":"2022-09-15T12:33:03.645Z","createdAt":"2022-09-15T12:33:03.724Z","updatedAt":"2022-10-02T10:01:54.588Z","abilities":[{"subject":"User","actions":["password","view-mine","update-mine"]},{"subject":"Product","actions":["view","order"]},{"subject":"Subscription","actions":["view"]},{"subject":"Order","actions":["save","calculate","view","cancel"]},{"subject":"Notification","actions":["view","subscribe","mark-as-read"]}]}

class MineModel {
  MineModel({
    MineData? data,
  }) {
    _data = data;
  }

  MineModel.fromJson(dynamic json) {
    _data = json['data'] != null ? MineData.fromJson(json['data']) : null;
  }
  MineData? _data;
  MineModel copyWith({
    MineData? data,
  }) =>
      MineModel(
        data: data ?? _data,
      );
  MineData? get data => _data;

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
/// updatedAt : "2022-10-02T10:01:54.588Z"
/// abilities : [{"subject":"User","actions":["password","view-mine","update-mine"]},{"subject":"Product","actions":["view","order"]},{"subject":"Subscription","actions":["view"]},{"subject":"Order","actions":["save","calculate","view","cancel"]},{"subject":"Notification","actions":["view","subscribe","mark-as-read"]}]

class MineData {
  MineData({
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
    List<Abilities>? abilities,
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
    _abilities = abilities;
  }

  MineData.fromJson(dynamic json) {
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
    if (json['abilities'] != null) {
      _abilities = [];
      json['abilities'].forEach((v) {
        _abilities?.add(Abilities.fromJson(v));
      });
    }
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
  List<Abilities>? _abilities;
  MineData copyWith({
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
    List<Abilities>? abilities,
  }) =>
      MineData(
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
        abilities: abilities ?? _abilities,
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
  List<Abilities>? get abilities => _abilities;

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
    if (_abilities != null) {
      map['abilities'] = _abilities?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// subject : "User"
/// actions : ["password","view-mine","update-mine"]

class Abilities {
  Abilities({
    String? subject,
    List<String>? actions,
  }) {
    _subject = subject;
    _actions = actions;
  }

  Abilities.fromJson(dynamic json) {
    _subject = json['subject'];
    _actions = json['actions'] != null ? json['actions'].cast<String>() : [];
  }
  String? _subject;
  List<String>? _actions;
  Abilities copyWith({
    String? subject,
    List<String>? actions,
  }) =>
      Abilities(
        subject: subject ?? _subject,
        actions: actions ?? _actions,
      );
  String? get subject => _subject;
  List<String>? get actions => _actions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subject'] = _subject;
    map['actions'] = _actions;
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
