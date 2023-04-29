import 'dart:convert';
import 'dart:core';
import 'dart:io';



import 'package:butransit/constraint/error_handling.dart';
import 'package:butransit/constraint/utills.dart';
import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/auth/screen/healthscreen.dart';
import 'package:butransit/features/auth/screen/phoneverifi.dart';
import 'package:butransit/features/map/screen/mapscreen.dart';
import 'package:butransit/model/register_response_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/provider.dart';

class RegisterService {
  void RegisterStudent({
    required BuildContext context,
    required String email,
    required String password,
    required String phone_no,
    required String matric_no,
  }) async {
    try {
      final Map<String, dynamic> jsonData = {
        'email': email,
        'password': password,
        'phone_no': phone_no,
        'matric_no': matric_no,
      };

      final String jsonString = jsonEncode(jsonData);

      SharedPreferences;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', jsonString);
      Navigator.pushNamed(context, HealthScreen.routeName);

      /* http.Response res_code = await http.post(
        Uri.parse('https://babcock-transit.onrender.com/api/v1/student/register'),
        body: {
          "email" : email,
          "password": password,
          "phone_no": phone_no,
          "matric_no": matric_no,
        }); */

      /* print(res_code.body);
      httpErrorHandle(response: response, context: context, onSuccess: () {
        showSnackBar(context, "account has been created");
      }); */


    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  void loginStudent({
    required BuildContext context,
    required String password,
    required String phone_no,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse(
              'https://babcock-transit.onrender.com/api/v1/student/login'),
          body: {
            'phone_no': phone_no,
            'password': password,
          });


      // debugPrint(res.body);
      if (kDebugMode) {
        print(res.body);
      }


      httpErrorHandle(response: res, context: context, onSuccess: () async {
        showSnackBar(context, jsonDecode(res.body)['succ_msg']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final setLogin   = jsonDecode(res.body)['result']['user_data'];
        final setLoginstring = jsonEncode(setLogin);
        Provider.of<UserProvider>(context, listen: false).setUser(setLoginstring);
        await prefs.setString(
            'token', jsonDecode(res.body)['result']['auth_token']);
         /*
       final setLogintoken = jsonDecode(res.body)['result']['auth_token'];
       final setLoginStringtoken = jsonEncode(setLogintoken);*/
        Navigator.pushNamedAndRemoveUntil(
            context,
            MapScreen.routeName,
                (route) => false);
        // Navigator.pushNamed(context, MapScreen.routeName);

      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void healthReport({
    required BuildContext context,
    required String name,
    required String gender,
    required String hostel,
    required List<File> images,
  }) async {
    try {

      final cloudinary = CloudinaryPublic('detjbvvp6', 'wmjhlswd');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }



      SharedPreferences prefs = await SharedPreferences.getInstance();
      var stringValue = prefs.getString("userData");
      Map<String, dynamic> jsonMap = jsonDecode(stringValue!);
      Map<String, dynamic> newMap = {
        'name': name,
        'gender': gender,
        'hostel': hostel,
      };

      jsonMap.addAll(newMap);
      String healthReport = jsonEncode(jsonMap);
      http.Response res_code = await http.post(
          Uri.parse(
              'https://babcock-transit.onrender.com/api/v1/student/register'),
          body: healthReport);

      //jsonEncode turns string to json
      //jsonDecode turns it back to string


      print(healthReport);
      print(res_code.body);

      httpErrorHandle(response: res_code, context: context, onSuccess: () {
        showSnackBar(context, jsonDecode(res_code.body)['message']);
        Navigator.pushNamedAndRemoveUntil(context, Phoneverification.routeName, (route) => false);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void forNewToken({
    required BuildContext context,
    required String studentid,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse(
          "https://babcock-transit.onrender.com/api/v1/student/generate-new-verification-code"),
        body: {
          "student_id": studentid,
        },

      );

      print(res.body);

      httpErrorHandle(response: res, context: context, onSuccess: () {
        showSnackBar(context, jsonDecode(res.body)['message']);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}



/*
  class LoginProvider  with ChangeNotifier{

  bool  _loading = false

    void loginStudent({
      required BuildContext context,
      required String password,
      required String phone_no,
    }) async {
      try{
        http.Response res = await http.post(
            Uri.parse('https://babcock-transit.onrender.com/api/v1/student/login'),
            body: {
              'phone_no': phone_no,
              'password':password,
            });


        // debugPrint(res.body);
        if (kDebugMode) {
          print(res.body);
        }


        httpErrorHandle(response: res, context: context, onSuccess: () async  {
          showSnackBar(context, jsonDecode(res.body)['succ_msg']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await  prefs.setString(
              'token', jsonDecode(res.body)['result']['auth_token']);
          /*final setLogin   = jsonDecode(res.body)['result']['auth_token'];
        final setLoginstring = jsonEncode(setLogin);
       final setLogintoken = jsonDecode(res.body)['result']['auth_token'];
       final setLoginStringtoken = jsonEncode(setLogintoken);*/
          Navigator.pushNamedAndRemoveUntil(
              context,
              MapScreen.routeName,
                  (route) => false);
          // Navigator.pushNamed(context, MapScreen.routeName);

        } );


      }catch(e){
        showSnackBar(context, e.toString());
      }
    }

 */








