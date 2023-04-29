class LoginRequestModel {
  LoginRequestModel({
    this.phone_no,
    this.password,
  });
  late final String? phone_no;
  late final String? password;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    phone_no = json['phone_no'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone_no'] = phone_no;
    _data['password'] = password;
    return _data;
  }
}
