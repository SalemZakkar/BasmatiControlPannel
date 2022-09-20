import 'dart:convert';

/// inProgress : false
/// success : false
/// failure : false
/// errorMessage : ""

StateStatus stateStatusFromJson(String str) =>
    StateStatus.fromJson(json.decode(str));

String stateStatusToJson(StateStatus data) => json.encode(data.toJson());

class StateStatus {
  StateStatus({
    bool? inProgress,
    bool? success,
    bool? failure,
    String? errorMessage,
  }) {
    _inProgress = inProgress;
    _success = success;
    _failure = failure;
    _errorMessage = errorMessage;
  }

  StateStatus.fromJson(dynamic json) {
    _inProgress = json['inProgress'];
    _success = json['success'];
    _failure = json['failure'];
    _errorMessage = json['errorMessage'];
  }

  bool? _inProgress;
  bool? _success;
  bool? _failure;
  String? _errorMessage;

  StateStatus copyWith({
    bool? inProgress,
    bool? success,
    bool? failure,
    String? errorMessage,
  }) =>
      StateStatus(
        inProgress: inProgress ?? _inProgress,
        success: success ?? _success,
        failure: failure ?? _failure,
        errorMessage: errorMessage ?? _errorMessage,
      );

  bool? get inProgress => _inProgress;

  bool? get success => _success;

  bool? get failure => _failure;

  String? get errorMessage => _errorMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inProgress'] = _inProgress;
    map['success'] = _success;
    map['failure'] = _failure;
    map['errorMessage'] = _errorMessage;
    return map;
  }
}
