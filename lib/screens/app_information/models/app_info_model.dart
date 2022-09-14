/// data : {"id":"000000050000000000000000","description":"لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديد يونتيوت لابوري ات دولار ماجنا أليكيوا . يوت انيم أد مينيم فينايم,كيواس نوستريد أكسير سيتاشن يللأمكو لابورأس نيسي يت أليكيوب أكس أيا كوممودو كونسيكيوات.","whatsApp":["+963962213470"],"phones":["+963962213470"],"mobiles":["+963962213470"]}

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
/// phones : ["+963962213470"]
/// mobiles : ["+963962213470"]

class AppInfoData {
  AppInfoData({
    String? id,
    String? description,
    List<String>? whatsApp,
    List<String>? phones,
    List<String>? mobiles,
  }) {
    _id = id;
    _description = description;
    _whatsApp = whatsApp;
    _phones = phones;
    _mobiles = mobiles;
  }

  AppInfoData.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _whatsApp = json['whatsApp'] != null ? json['whatsApp'].cast<String>() : [];
    _phones = json['phones'] != null ? json['phones'].cast<String>() : [];
    _mobiles = json['mobiles'] != null ? json['mobiles'].cast<String>() : [];
  }
  String? _id;
  String? _description;
  List<String>? _whatsApp;
  List<String>? _phones;
  List<String>? _mobiles;
  AppInfoData copyWith({
    String? id,
    String? description,
    List<String>? whatsApp,
    List<String>? phones,
    List<String>? mobiles,
  }) =>
      AppInfoData(
        id: id ?? _id,
        description: description ?? _description,
        whatsApp: whatsApp ?? _whatsApp,
        phones: phones ?? _phones,
        mobiles: mobiles ?? _mobiles,
      );
  String? get id => _id;
  String? get description => _description;
  List<String>? get whatsApp => _whatsApp;
  List<String>? get phones => _phones;
  List<String>? get mobiles => _mobiles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    map['whatsApp'] = _whatsApp;
    map['phones'] = _phones;
    map['mobiles'] = _mobiles;
    return map;
  }
}
