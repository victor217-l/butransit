import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import 'package:butransit/model/register_response_model.dart';


class UserProvider extends ChangeNotifier{
  User _user = User(
    id: '',
   location_name: '',
    email: '',
    password: '',
    gender: '',
    hostel: '',
    type: '',
    matric_no: '',
    phone_no : '',
    token: '',// images: [],
  );


  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}


