/// data : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAwMDAwMDAyMDAwMDAwMDAwMDAwMDAwMSIsImlhdCI6MTY2MjQxMDA5MSwiZXhwIjoxNjY0MTM4MDkxfQ.U4S6QaoqDyee_Q29nGfkmgOPSrfjs78TrFKQiuoesVY","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAwMDAwMDAyMDAwMDAwMDAwMDAwMDAwMSIsImlhdCI6MTY2MjI5MTY4M30.WmlTa3FuKldOUteng0dy_sElQNNwqNrkit68yxYqpCY"}

class TokenData {
  TokenData({
    Data? data,
  }) {
    _data = data;
  }

  TokenData.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  TokenData copyWith({
    Data? data,
  }) =>
      TokenData(
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

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAwMDAwMDAyMDAwMDAwMDAwMDAwMDAwMSIsImlhdCI6MTY2MjQxMDA5MSwiZXhwIjoxNjY0MTM4MDkxfQ.U4S6QaoqDyee_Q29nGfkmgOPSrfjs78TrFKQiuoesVY"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAwMDAwMDAyMDAwMDAwMDAwMDAwMDAwMSIsImlhdCI6MTY2MjI5MTY4M30.WmlTa3FuKldOUteng0dy_sElQNNwqNrkit68yxYqpCY"

class Data {
  Data({
    String? accessToken,
    String? refreshToken,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  Data.fromJson(dynamic json) {
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
  }

  String? _accessToken;
  String? _refreshToken;

  Data copyWith({
    String? accessToken,
    String? refreshToken,
  }) =>
      Data(
        accessToken: accessToken ?? _accessToken,
        refreshToken: refreshToken ?? _refreshToken,
      );

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    return map;
  }
}
