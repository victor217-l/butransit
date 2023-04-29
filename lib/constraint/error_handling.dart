import 'dart:convert';

import 'utills.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess, //Function()?
}) {
  switch(response.statusCode){
    case 200:
    onSuccess();
    break;
    case 400:
    showSnackBar(context, jsonDecode(response.body)['err_msg']);
    break;
    case 500:
    showSnackBar(context, jsonDecode(response.body)['err_msg']);
    break;                      
    default:         
      showSnackBar(context, response.body);
  }
}
