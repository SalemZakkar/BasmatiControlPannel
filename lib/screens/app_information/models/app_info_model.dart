/// data : {"id":"000000050000000000000000","description":"لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديد يونتيوت لابوري ات دولار ماجنا أليكيوا . يوت انيم أد مينيم فينايم,كيواس نوستريد أكسير سيتاشن يللأمكو لابورأس نيسي يت أليكيوب أكس أيا كوممودو كونسيكيوات.","whatsApp":["+963962213470"],"phones":["dfgdfgfdg"],"mobiles":["dfgdfgdfgdfg"],"instagram":"vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv","facebook":"jjjj","linkedIn":"ggg","snapchat":"ggg"}

class AppInfoModel {
  AppInfoModel({
    AppInfoData? data,
  }) {
    _data = data;
  }

  AppInfoModel.fromJson(dynamic json) {
    _data = json['data'] != null ? AppInfoData.fromJson(json['data']) : null;
  }
  AppInfoData? _data;
  AppInfoModel copyWith({
    AppInfoData? data,
  }) =>
      AppInfoModel(
        data: data ?? _data,
      );
  AppInfoData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : "000000050000000000000000"
/// description : "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديد يونتيوت لابوري ات دولار ماجنا أليكيوا . يوت انيم أد مينيم فينايم,كيواس نوستريد أكسير سيتاشن يللأمكو لابورأس نيسي يت أليكيوب أكس أيا كوممودو كونسيكيوات."
/// whatsApp : ["+963962213470"]
/// phones : ["dfgdfgfdg"]
/// mobiles : ["dfgdfgdfgdfg"]
/// instagram : "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
/// facebook : "jjjj"
/// linkedIn : "ggg"
/// snapchat : "ggg"

class AppInfoData {
  AppInfoData({
    String? id,
    String? description,
    List<String>? whatsApp,
    List<String>? phones,
    List<String>? mobiles,
    String? instagram,
    String? facebook,
    String? linkedIn,
    String? snapchat,
  }) {
    _id = id;
    _description = description;
    _whatsApp = whatsApp;
    _phones = phones;
    _mobiles = mobiles;
    _instagram = instagram;
    _facebook = facebook;
    _linkedIn = linkedIn;
    _snapchat = snapchat;
  }

  AppInfoData.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _whatsApp = json['whatsApp'] != null ? json['whatsApp'].cast<String>() : [];
    _phones = json['phones'] != null ? json['phones'].cast<String>() : [];
    _mobiles = json['mobiles'] != null ? json['mobiles'].cast<String>() : [];
    _instagram = json['instagram'];
    _facebook = json['facebook'];
    _linkedIn = json['linkedIn'];
    _snapchat = json['snapchat'];
  }
  String? _id;
  String? _description;
  List<String>? _whatsApp;
  List<String>? _phones;
  List<String>? _mobiles;
  String? _instagram;
  String? _facebook;
  String? _linkedIn;
  String? _snapchat;
  AppInfoData copyWith({
    String? id,
    String? description,
    List<String>? whatsApp,
    List<String>? phones,
    List<String>? mobiles,
    String? instagram,
    String? facebook,
    String? linkedIn,
    String? snapchat,
  }) =>
      AppInfoData(
        id: id ?? _id,
        description: description ?? _description,
        whatsApp: whatsApp ?? _whatsApp,
        phones: phones ?? _phones,
        mobiles: mobiles ?? _mobiles,
        instagram: instagram ?? _instagram,
        facebook: facebook ?? _facebook,
        linkedIn: linkedIn ?? _linkedIn,
        snapchat: snapchat ?? _snapchat,
      );
  String? get id => _id;
  String? get description => _description;
  List<String>? get whatsApp => _whatsApp;
  List<String>? get phones => _phones;
  List<String>? get mobiles => _mobiles;
  String? get instagram => _instagram;
  String? get facebook => _facebook;
  String? get linkedIn => _linkedIn;
  String? get snapchat => _snapchat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    map['whatsApp'] = _whatsApp;
    map['phones'] = _phones;
    map['mobiles'] = _mobiles;
    map['instagram'] = _instagram;
    map['facebook'] = _facebook;
    map['linkedIn'] = _linkedIn;
    map['snapchat'] = _snapchat;
    return map;
  }
}
