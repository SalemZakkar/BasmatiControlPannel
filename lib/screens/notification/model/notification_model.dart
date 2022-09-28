/// totalRecords : 4
/// data : [{"id":"632dcf5199aa1a482ce73317","title":"test","body":"test","markedAsRead":false,"createdAt":"2022-09-23T15:22:57.119Z"},{"id":"632c6df68eb23c1655ed0286","title":"test","body":"test","markedAsRead":false,"createdAt":"2022-09-22T14:15:18.643Z"},{"id":"6324b0aa5247ad8198bcb414","title":"test","body":"test","markedAsRead":false,"createdAt":"2022-09-16T17:21:46.344Z"},{"id":"6324972795c79166c15fc767","title":"test","body":"test","markedAsRead":true,"createdAt":"2022-09-16T15:32:55.968Z"}]

class NotificationModel {
  NotificationModel({
    num? totalRecords,
    List<NotificationData>? data,
  }) {
    _totalRecords = totalRecords;
    _data = data;
  }

  NotificationModel.fromJson(dynamic json) {
    _totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
  }
  num? _totalRecords;
  List<NotificationData>? _data;
  NotificationModel copyWith({
    num? totalRecords,
    List<NotificationData>? data,
  }) =>
      NotificationModel(
        totalRecords: totalRecords ?? _totalRecords,
        data: data ?? _data,
      );
  num? get totalRecords => _totalRecords;
  List<NotificationData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRecords'] = _totalRecords;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "632dcf5199aa1a482ce73317"
/// title : "test"
/// body : "test"
/// markedAsRead : false
/// createdAt : "2022-09-23T15:22:57.119Z"

class NotificationData {
  NotificationData({
    String? id,
    String? title,
    String? body,
    bool? markedAsRead,
    String? createdAt,
  }) {
    _id = id;
    _title = title;
    _body = body;
    _markedAsRead = markedAsRead;
    _createdAt = createdAt;
  }

  NotificationData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _markedAsRead = json['markedAsRead'];
    _createdAt = json['createdAt'];
  }
  String? _id;
  String? _title;
  String? _body;
  bool? _markedAsRead;
  String? _createdAt;
  NotificationData copyWith({
    String? id,
    String? title,
    String? body,
    bool? markedAsRead,
    String? createdAt,
  }) =>
      NotificationData(
        id: id ?? _id,
        title: title ?? _title,
        body: body ?? _body,
        markedAsRead: markedAsRead ?? _markedAsRead,
        createdAt: createdAt ?? _createdAt,
      );
  String? get id => _id;
  String? get title => _title;
  String? get body => _body;
  bool? get markedAsRead => _markedAsRead;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    map['markedAsRead'] = _markedAsRead;
    map['createdAt'] = _createdAt;
    return map;
  }
}
