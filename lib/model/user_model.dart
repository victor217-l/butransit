import 'dart:convert';

class User {
  final String id;
  final String location_name;
  final String password;
  final String email;
  final String phone_no;
  final String gender;
 // Result result;
 // final List<String> images;
  final String type;
  final String token;
  final String matric_no;
  final String hostel;

  User({required this.id,
    required this.location_name,
    required this.email,
    required this.password,
    required this.phone_no,
  //  required this.images,
    required this.gender,
    required this.type,
   // required this.result,
    required this.matric_no,
    required this.hostel,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      //'images':images,
      'id': id,
     // "result": result.toJson(),
      'location_name': location_name,
      'email': email,
      'hostel': hostel,
      'gender': gender,
      'matric_no': matric_no,
      'password': password,
      'phone_no': phone_no,
      'type': type,
      'token': token,

    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      location_name: map['location_name'] ?? '',
      email: map['email'] ?? '',
     // result: map['result'] ?? '',
      gender: map['gender'] ?? '',
      password: map['password'] ?? '',
      phone_no: map['phone_no'] ?? '',
      hostel: map['hostel'] ?? '',
      matric_no: map['matric_no'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    //  images: List<String>.from(map['images']),

    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

/*
Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.errMsg,
    required this.result,
    required this.succMsg,
    required this.resCode,
  });

  dynamic errMsg;
  Result result;
  String succMsg;
  int resCode;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    errMsg: json["err_msg"],
    result: Result.fromJson(json["result"]),
    succMsg: json["succ_msg"],
    resCode: json["res_code"],
  );

  Map<String, dynamic> toJson() => {
    "err_msg": errMsg,
    "result": result.toJson(),
    "succ_msg": succMsg,
    "res_code": resCode,
  };
}


 */

class Result {
  Result({
    required this.authToken,
    required this.userData,
  });

  String authToken;
  UserData userData;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    authToken: json["auth_token"],
    userData: UserData.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "auth_token": authToken,
    "user_data": userData.toJson(),
  };
}

class UserData {
  UserData({
    required this.name,
    required this.profileImage,
  });

  String name;
  String profileImage;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    name: json["name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "profile_image": profileImage,
  };
}
