import 'dart:convert';


import 'dart:convert';

RegisterResponseModel registerResponseJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data? data;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.username,
    required this.email,
    required this.date,
    required this.id,
  });
  late final String username;
  late final String email;
  late final String date;
  late final String id;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['date'] = date;
    _data['id'] = id;
    return _data;
  }
}






/*class Register {
  final String id;
  final String password;
  final String email;
  final String phone_no;
  final String matric_no;


  Register({required this.id,
    required this.email,
    required this.password,
    required this.phone_no,

    required this.matric_no,


  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'matric': matric_no,
      'password': password,
      'phone_no': phone_no,

    };
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      id: map['id'] ?? '',

      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone_no: map['phone_no'] ?? '',
      matric_no: map['matric_no'] ?? '',


    );
  }

  String toJson() => json.encode(toMap());

  factory Register.fromJson(String source) => Register.fromMap(json.decode(source));
} */
