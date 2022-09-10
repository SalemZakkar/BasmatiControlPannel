/// data : {"id":"000000020000000000000001","type":"Admin","fullName":"Admin","phone":"+9660000000001","email":"admin1@Basmati.com","avatar":{"id":"000000010000000200000001","url":"https://basmati-v1.herokuapp.com/assets/public/user/avatars/000000010000000200000001.png"},"isActive":true,"isVerified":{"email":false,"phone":false},"lastLogin":"2022-09-04T11:35:43.442Z","createdAt":"2022-09-04T11:35:43.638Z","updatedAt":"2022-09-05T20:43:54.059Z","abilities":[{"subject":"User","actions":["save","update","delete","activate","view","view-mine","update-mine","password"]},{"subject":"Product","actions":["manage"]}]}

class AuthData {
  AuthData({
    Data? data,
  }) {
    _data = data;
  }

  AuthData.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  AuthData copyWith({
    Data? data,
  }) =>
      AuthData(
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

/// id : "000000020000000000000001"
/// type : "Admin"
/// fullName : "Admin"
/// phone : "+9660000000001"
/// email : "admin1@Basmati.com"
/// avatar : {"id":"000000010000000200000001","url":"https://basmati-v1.herokuapp.com/assets/public/user/avatars/000000010000000200000001.png"}
/// isActive : true
/// isVerified : {"email":false,"phone":false}
/// lastLogin : "2022-09-04T11:35:43.442Z"
/// createdAt : "2022-09-04T11:35:43.638Z"
/// updatedAt : "2022-09-05T20:43:54.059Z"
/// abilities : [{"subject":"User","actions":["save","update","delete","activate","view","view-mine","update-mine","password"]},{"subject":"Product","actions":["manage"]}]

class Data {
  Data({
    String? id,
    String? type,
    String? fullName,
    String? phone,
    String? email,
    Avatar? avatar,
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

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _fullName = json['fullName'];
    _phone = json['phone'];
    _email = json['email'];
    _avatar = json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
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
  Avatar? _avatar;
  bool? _isActive;
  IsVerified? _isVerified;
  String? _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  List<Abilities>? _abilities;

  Data copyWith({
    String? id,
    String? type,
    String? fullName,
    String? phone,
    String? email,
    Avatar? avatar,
    bool? isActive,
    IsVerified? isVerified,
    String? lastLogin,
    String? createdAt,
    String? updatedAt,
    List<Abilities>? abilities,
  }) =>
      Data(
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

  Avatar? get avatar => _avatar;

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
    if (_avatar != null) {
      map['avatar'] = _avatar?.toJson();
    }
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
/// actions : ["save","update","delete","activate","view","view-mine","update-mine","password"]

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

/// id : "000000010000000200000001"
/// url : "https://basmati-v1.herokuapp.com/assets/public/user/avatars/000000010000000200000001.png"

class Avatar {
  Avatar({
    String? id,
    String? url,
  }) {
    _id = id;
    _url = url;
  }

  Avatar.fromJson(dynamic json) {
    _id = json['id'];
    _url = json['url'];
  }

  String? _id;
  String? _url;

  Avatar copyWith({
    String? id,
    String? url,
  }) =>
      Avatar(
        id: id ?? _id,
        url: url ?? _url,
      );

  String? get id => _id;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['url'] = _url;
    return map;
  }
}
