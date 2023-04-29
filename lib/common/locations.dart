
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToLocation extends StatelessWidget {
  final String text;
  const ToLocation({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6.0,
            spreadRadius: 0.5,
            offset: Offset(0.7, 0.7)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.white,),
            SizedBox(width: 10,),
            Text(text)
          ],
        ),
      ),
    );
  }
}

class WhereTo extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  const WhereTo({Key? key, required this.controller, required this.hintext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.grey,
        hintText: hintext,
        focusColor: Colors.grey ,
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
        disabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
        focusedBorder:
        OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
        errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0
            )
        ),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintext';
        }
      },
    );
  }
}

