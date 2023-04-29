
import 'dart:convert';

import 'package:butransit/common/globalvariables.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    padding: EdgeInsets.all(15.0),
    elevation: 10.0,
    behavior: SnackBarBehavior.floating,
    content: Text(text, style:
  TextStyle(fontSize: 15, color: Colors.white),),
    backgroundColor: GlobalVariables.primaryColor, shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12))
  ), ));
}


Future<List<File>> pickFiles() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
       images.add(File(files.files[i].path!));
      }

    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;
}


 /* Future<File?> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result != null){
     File file = File(result.files.single.path);
    }else{
      return null;
    }
  }
  */


