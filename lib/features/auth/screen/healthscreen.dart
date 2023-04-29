

import 'dart:io';

import 'package:butransit/common/custombutton.dart';
import 'package:butransit/common/customtextfie.dart';
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/driver/screen/loginfordeiver.dart';
import 'package:butransit/features/driver/screen/vehiclereport.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constraint/utills.dart';
import '../service/registerservice.dart';

class HealthScreen extends StatefulWidget {
  static const String routeName = '/vehiclescreen';
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreen();
}

class _HealthScreen extends State<HealthScreen> {
  final _healthstudent = GlobalKey<FormState>();


  final RegisterService registerservice = RegisterService();



  final TextEditingController _studentController = TextEditingController();
  final TextEditingController _gendercontroller = TextEditingController();
  final TextEditingController _hostelController = TextEditingController();
  final TextEditingController _attachmentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _studentController.dispose();
    _gendercontroller.dispose();
    _hostelController.dispose();
  }

  List<File> images = [];

  void healthreport(){
    registerservice.healthReport(
      context: context,
     name : _studentController.text,
      gender: _gendercontroller.text,
      hostel: _hostelController.text, images: images,
    );
  }

   void selectImages() async {
    var res = await pickFiles();
    setState(() {
      images = res;
    });
  }
 bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text("Health Report", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),),
                Text("for student",
                    style: TextStyle(fontSize: 20, color: Colors.grey)),

                SizedBox(height: 20,),
                Form(
                    key: _healthstudent,
                    child: Column(
                      children: [
                        CustomTextfield(
                            controller: _studentController,
                            hintext: "Name"),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextfield(controller: _gendercontroller, hintext: "gender",),
                        //Input
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextfield(
                            controller: _hostelController,
                            hintext: "hostel"),
                        const SizedBox(
                          height: 20,
                        ),
                        images.isNotEmpty
                            ? CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                builder: (BuildContext context) =>
                                    Image.file(i, fit: BoxFit.cover, height: 50),
                              );
                            }).toList(),
                            options:
                            CarouselOptions(viewportFraction: 1, height: 50))
                         : GestureDetector(
                           onTap: selectImages,
                           child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),

                              ],
                            ),
                        ),
                         ),
                        SizedBox(height: 6,),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style:ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.0))),
                                minimumSize: Size(
                                    double.infinity, 50),
                                primary: GlobalVariables.primaryColor),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                                healthreport();
                              await Future.delayed(const Duration(seconds: 30));
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: (isLoading)
                                ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.5,
                                ))
                                : const Text('register'),
                          ),
                        ),
                      ],
                    )),
                //Input file

                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      const Text("Already have an account?", textAlign: TextAlign.center,),
                      const SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GlobalVariables.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),


                const SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.center,
                child: Text(
                    "Terms and conditions", textAlign: TextAlign.center,

                  ),
                ),



              ]),
        ),
      ),
    );
  }
}

//Nelson Mandela
//Bethel Splendor
//Queen Esther
//Silicon Valley

