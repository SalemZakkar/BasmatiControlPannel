/// code : "0603"
/// msg : "Invalid authentication phone or password."

class ErrorData {
  ErrorData({
    String? code,
    String? msg,
  }) {
    _code = code;
    _msg = msg;
  }

  ErrorData.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }

  String? _code;
  String? _msg;

  ErrorData copyWith({
    String? code,
    String? msg,
  }) =>
      ErrorData(
        code: code ?? _code,
        msg: msg ?? _msg,
      );

  String? get code => _code;

  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    return map;
  }
}
