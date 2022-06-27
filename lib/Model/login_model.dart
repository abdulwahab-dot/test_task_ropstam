import 'dart:convert';

class LoginModel {
  bool? success;
  int? statusCode;
  String? code;
  String? message;
  Data? data;

  LoginModel(
      {this.data, this.statusCode, this.code, this.message, this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['code'] = code;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? email;

  Data({
    this.email,
  });

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;

    return data;
  }
}
