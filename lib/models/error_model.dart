class ErrorModel {
  Error? error;

  ErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }
}

class Error {
  int? code;
  String? message;

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
}
