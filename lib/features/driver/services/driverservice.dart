import 'dart:convert';
import 'dart:core';
import 'dart:io';


import 'package:butransit/constraint/error_handling.dart';
import 'package:butransit/constraint/utills.dart';
import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/driver/screen/registerscreenfordriver.dart';
import 'package:butransit/features/driver/screen/seerides.dart';
import 'package:butransit/features/driver/screen/vehiclereport.dart';
import 'package:butransit/features/map/screen/mapscreen.dart';
import 'package:butransit/model/register_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/fordriver_model.dart';
import '../../../model/listofdriver.dart';
import '../../../provider/provider.dart';


class DriverService{
  void RegisterDriver({
    required BuildContext context,
    required String email,
    required String password,
    required String phone_no,
  }) async {
    try{

      final Map<String, dynamic> jsonData = {
        'email':email,
        'password':password,
        'phone_no':phone_no,
      };

      final String jsonString = jsonEncode(jsonData);

      SharedPreferences; final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData1', jsonString);
      Navigator.pushNamed(context, VehicleReport.routeName);

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




    }catch(e){
      showSnackBar(context, e.toString() );
    }
  }


  void vehicleReports({
    required BuildContext context,
    required String name,
    required String gender,
    required String platenumber,
    required List<File> images,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var stringValue = prefs.getString("userData1");
      Map<String, dynamic> jsonMap = jsonDecode(stringValue!);
      Map<String, dynamic> newMap = {
        'name': name,
        'gender': gender,
        'plate_number': platenumber,
        'file': images,
      };

      jsonMap.addAll(newMap);
      String verhicleReport = jsonEncode(jsonMap);
      http.Response res_code = await http.post(
          Uri.parse(
              'https://babcock-transit.onrender.com/api/v1/student/register'),
          body: verhicleReport);

      //jsonEncode turns string to json
      //jsonDecode turns it back to string


      print(verhicleReport);
      print(res_code.body);

      httpErrorHandle(response: res_code, context: context, onSuccess: () {
        showSnackBar(context, jsonDecode(res_code.body)['message']);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }



  void  LoginDriver({
    required BuildContext context,
    required String phone_no,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('https://babcock-transit.onrender.com/api/v1/driver/login'),
        body: jsonEncode({
          'phone_no': phone_no,
          'password':password,
        }),

        headers: <String, String>{
          'Content-type': 'application/json; charset=utf-8'
        },);

      print(res.body);

      httpErrorHandle(response: res, context: context, onSuccess: () async  {
        showSnackBar(context, jsonDecode(res.body)['succ_msg']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
      //  Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        await  prefs.setString(
            'tokenn', jsonDecode(res.body)['result']['auth_token']);
        /*final setLogin   = jsonDecode(res.body)['result']['auth_token'];
        final setLoginstring = jsonEncode(setLogin);
       final setLogintoken = jsonDecode(res.body)['result']['auth_token'];
       final setLoginStringtoken = jsonEncode(setLogintoken);*/
        Navigator.pushNamedAndRemoveUntil(
            context,
            DriverRide.routeName,
                (route) => false);
        // Navigator.pushNamed(context, MapScreen.routeName);

      } );
    }catch(e){
      showSnackBar(context, e.toString() );
    }
  }

  void  otpVerificatonForDrivers({
    required BuildContext context,
    required String code,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context).user;
      http.Response res = await http.post(
        Uri.parse('https://babcock-transit.onrender.com/api/v1/driver/list-all-rides'),
        body: {
          "id" :userProvider.id,
          "verification_code":code,
        },);

      httpErrorHandle(response: res, context: context, onSuccess: () async  {
        showSnackBar(context, jsonDecode(res.body)['succ_msg']);

        // Navigator.pushNamed(context, MapScreen.routeName);

      } );
    }catch(e){
      showSnackBar(context, e.toString() );
    }
  }





   Future<List<Ride>> fetchListOfRides(BuildContext context) async {
    List<Ride> drierRide = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
     final tokens = await prefs.getString("tokenn");
    try {
      http.Response res = await http.post(Uri.parse('https://babcock-transit.onrender.com/api/v1/driver/list-all-rides'),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Authorization': 'Bearer $tokens',
        },);
      print(res.body);

 print(tokens);
      httpErrorHandle(response: res, context: context, onSuccess: ()   {
        for(int i =0; i < jsonDecode(res.body)['result'].length; i++){
         drierRide.add(
              Ride.fromJson(jsonEncode(jsonDecode(res.body)['result'][i])));
        }
      } );


    /*  for (int i = 0; i < jsonDecode(res.body)['result'].length; i++) {
        driverList
            .add(
            Driver.fromJson(jsonEncode(jsonDecode(res.body)['result'][i])));
      }
    }); */





    }catch(e){
      showSnackBar(context, e.toString() );
    }
    return drierRide;
  }

  void cancelRidefordriver({
    required BuildContext context,
    required Ride ride,
    required VoidCallback onSuccess,
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString("token");


      http.Response res = await http.post(
          Uri.parse("https://babcock-transit.onrender.com/api/v1/student/cancel-ride"),
          headers: <String, String>{
            "Content-type": "application/json;charset-UTF=8",
            "Authorization": 'Bearer $token'
          },
          body: jsonEncode({
            'transport_ride_id': ride.rideId,
          }));

      print(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
            showSnackBar(context, jsonDecode(res.body)['succ_msg']);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logoutfordriver(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokenn','');
    Navigator.pushNamedAndRemoveUntil(context, RegisterDriverScreen.routeName, (route) => false);

  }


  void  rideDetailsDrivers({
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('https://babcock-transit.onrender.com/api/v1/driver/ride-details'),
        body: {

        },
        headers: <String, String>{
          'Content-type': 'application/json; charset=utf-8',

        },);

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
      showSnackBar(context, e.toString() );
    }
  }




}