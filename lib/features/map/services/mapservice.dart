import 'dart:convert';
import 'dart:ffi';

import 'package:butransit/features/auth/screen/registerscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constraint/error_handling.dart';
import '../../../constraint/utills.dart';
import '../../../model/fordriver_model.dart';
import '../../../model/forstudent_model.dart';
import '../../../model/listofdriver.dart';
import '../../../provider/fordriver_provider.dart';
import '../../../provider/provider.dart';


class MapService {
  void searchLocation({
    required BuildContext context,
    required String search,

  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString("token");

      http.Response res = await http.post(
        Uri.parse(
            'https://babcock-transit.onrender.com/api/v1/student/search-location'),
        body: jsonEncode({
          "search": search,
        }),

        headers: <String, String>{
          "Content-type": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        },);


      print(res.body);


      httpErrorHandle(response: res, context: context, onSuccess: () async {
        showSnackBar(context, jsonDecode(res.body)['succ_msg']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> jsonResponse = jsonDecode(res.body);
        String locationName = jsonResponse['result'][0]['location_name'];
        await prefs.setString("location", locationName);


        //  final setLogin   = jsonDecode(res.body)['result']['1'] as String;
        // final setLoginstring = jsonEncode(setLogin);
        // Provider.of<UserProvider>(context, listen: false).setUser(locationName);
      });

      // print(jsonDecode(res.body)['result']['1']);


    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logout(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token','');
    Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.routeName, (route) => false);

  }

  void Ambulancedet({
    required BuildContext context,
  required String current_location,
    required String  victim_name,
    required String   emergency_desc,
}) async {
    try{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString("token");


      http.Response res = await http.post( Uri.parse(
    'https://babcock-transit.onrender.com/api/v1/student/book-ambulance-ride'),
      body: jsonEncode({
        "current_location": current_location,
        "victim_name": victim_name,
        "emergency_state": "1",
        "vehicle_type": "ambulance",
        "arrival_time": 4 ,
        "emergency_desc":  emergency_desc,
      }),

        headers: <String, String>{
          "Content-type": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        },);
      print(res.body);
debugPrint(current_location);
debugPrint(victim_name);
debugPrint(emergency_desc);

httpErrorHandle(response: res, context: context, onSuccess: (){
         showSnackBar(context, jsonDecode(res.body)['succ_msg']);

      });



   }catch(e){
       showSnackBar(context, e.toString());
    }

}


  void Ambulancedetforwitness({
    required BuildContext context,
    required String current_location,
    required String  victim_name,
    required String  emergency_desc,
  }) async {
    try{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString("token");


      http.Response res = await http.post( Uri.parse(
          'https://babcock-transit.onrender.com/api/v1/student/book-ambulance-ride'),
        body: jsonEncode({
          "current_location": current_location,
          "victim_name": victim_name,
          "emergency_state": "2",
          "vehicle_type": "ambulance",
          "arrival_time": 4,
          "emergency_desc":  emergency_desc,
        }),

        headers: <String, String>{
          'Content-type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },);
      print(res.body);

      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, jsonDecode(res.body)['succ_msg']);

      });



    }catch(e){
      showSnackBar(context, e.toString());
    }

  }




  void cancelRide({
    required BuildContext context,
    required RideForStudent rideForStudent,
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
            'transport_ride_id': rideForStudent.rideId,
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

  Future<List<Driver>> fetchAlldriversavailble(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString("token");
    List<Driver> driverList = [];
    try {
      http.Response res = await http.post(Uri.parse(
          'https://babcock-transit.onrender.com/api/v1/student/fetch-available-drivers'),
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'Authorization': 'Bearer $token',
          }

      );

      print(res.body);

      httpErrorHandle(response: res, context: context, onSuccess: () {
        for (int i = 0; i < jsonDecode(res.body)['result'].length; i++) {
          driverList
              .add(
              Driver.fromJson(jsonEncode(jsonDecode(res.body)['result'][i])));
        //  print( Driver.fromJson(jsonEncode(jsonDecode(res.body)['result'][i])));
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return driverList;
  }

/*
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
   final userProvider = Provider.of<UserProvider>(context, listen: false);
   List<Product> productList = [];
   try {
     http.Response res =
     await http.get(Uri.parse('$uri/admin/get-products'), headers: {
       'Content-type': 'application/json;charset=UTF-8',
       'x-auth-token': userProvider.user.token,
     });

     httpErrorHandle(
         response: res,
         context: context,
         onSuccess: () {
           for (int i = 0; i < jsonDecode(res.body).length; i++) {
             productList
                 .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
           }
         });
   } catch (e) {
     showSnackBar(context, e.toString());
   }

   return productList;
 }
*/

  void bookRide({
    required BuildContext context,
    required String current_location,
    required String dropoff_location,
    required String arival_time,
    required String driver_id,
    required String ride_time,
    required String card_exp_month,
    required String card_exp_year,
    required String card_cvv,
    required String card_no,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await prefs.getString("token");


        SharedPreferences prefs1 = await SharedPreferences.getInstance();
        List<String> savedData = prefs1.getStringList('bank_detail') ?? [];


      Map<String, dynamic> requestBody = {
       // 'myList': savedData,
        "current_location":current_location,
        "dropoff_location":"location",
        "arrival_time":arival_time,
        "card_type": "1",
        "driver_id":driver_id,
        "ride_time":ride_time,
        "vehicle_type":"keke",
        "card_exp_month":card_exp_month,
        "card_exp_year":card_exp_year,
        "card_cvv":card_cvv,
        "card_no": card_no,
      };

      String jsonRequest = jsonEncode(requestBody);



      http.Response res = await http.post(Uri.parse(
          "https://babcock-transit.onrender.com/api/v1/student/book-keke-ride"),
          body: jsonRequest,



          headers: <String, String>{
            "Content-type": "application/json;charset-UTF=8",
            'Authorization': 'Bearer $token',
          }

      );
      debugPrint(driver_id);
      debugPrint(card_exp_year);
      debugPrint(card_exp_month);
      debugPrint(card_cvv);
      debugPrint(card_no);




      print(res.body);

      httpErrorHandle(response: res, context: context, onSuccess: () {


      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  /*
  "card_exp_month":card_exp_month,
            "card_exp_year":card_exp_year,
            "card_cvv":card_cvv,
            "card_no": card_no,
   */

   Future<List<RideForStudent>> fetchlistofstudent(BuildContext context) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     final token = await prefs.getString('token');
     List<RideForStudent> listofstudent = [];
     try{
       http.Response res = await http.post(
           Uri.parse("https://babcock-transit.onrender.com/api/v1/student/list-all-rides"),
         //  https://babcock-transit.onrender.com/api/v1/student/list-all-rides

         headers: <String, String> {
           "Content-type": "application/json;charset-UTF=8",
           'Authorization': 'Bearer $token',
         }
       );

       print(token);
        print(res.body);
       httpErrorHandle(response: res, context: context, onSuccess: () async {
         for(int i = 0; i <jsonDecode(res.body)['result'].length; i ++){
           listofstudent.add(
               RideForStudent.fromJson(jsonEncode(jsonDecode(res.body)['result'][i])));
         }

       });
     }catch(e){
       showSnackBar(context, e.toString());
     }
     return listofstudent;
     
   }



}
