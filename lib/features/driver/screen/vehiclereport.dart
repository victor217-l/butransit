import 'dart:io';

import 'package:butransit/features/driver/services/driverservice.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/custombutton.dart';
import '../../../common/customtextfie.dart';
import '../../../common/globalvariables.dart';
import '../../../constraint/utills.dart';
import '../../auth/screen/login.dart';
import 'loginfordeiver.dart';

class VehicleReport extends StatefulWidget {
  static const  String routeName = "/vehiclereport";
  const VehicleReport({Key? key}) : super(key: key);

  @override
  State<VehicleReport> createState() => _VehicleReportState();
}

class _VehicleReportState extends State<VehicleReport> {

  final _addkeytodriverregister = GlobalKey<FormState>();
  final TextEditingController _drivernamecontroller = TextEditingController();
  final   TextEditingController     _gendernamecontroller = TextEditingController();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _vehiclerportcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _drivernamecontroller.dispose();
    _plateController.dispose();
    _vehiclerportcontroller.dispose();

  }

  final DriverService driverService = DriverService();
  List<File> images = [];


  void vehicleReport(){
      driverService.vehicleReports(context: context,
          name: _drivernamecontroller.text,
          gender: _gendernamecontroller.text,
          platenumber: _plateController.text,
          images: images);
  }

  void selectImages() async {
    var res = await pickFiles();
    setState(() {
      images = res;
    });
  }

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
                Text("Vehicle Report", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),),
                Text("for driver",
                    style: TextStyle(fontSize: 20, color: Colors.white)),

                SizedBox(height: 20,),
                Form(
                    key: _addkeytodriverregister,
                    child: Column(
                      children: [
                        CustomTextfield(
                            controller: _drivernamecontroller,
                            hintext: "Driver's name"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                            controller: _gendernamecontroller,
                            hintext: "Gender"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                            controller: _plateController,
                            hintext: "Plate number"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                            controller: _vehiclerportcontroller,
                            hintext: "vehicle reports"),

                        const SizedBox(
                          height: 10,
                        ),
                        images.isNotEmpty
                            ? CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                builder: (BuildContext context) =>
                                    Image.file(i, fit: BoxFit.cover, height: 200),
                              );
                            }).toList(),
                            options:
                            CarouselOptions(viewportFraction: 1, height: 200))
                            : GestureDetector(
                          onTap: selectImages,
                          child: Container(
                            width: double.infinity,
                            height: 150,
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
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'select Product Images',
                                  style: TextStyle(color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                        CustomButton(
                          onTap: () {
                            if(_addkeytodriverregister.currentState!.validate()){
                              vehicleReport();
                            }
                          },
                          text: "Register", color: GlobalVariables.primaryColor,),
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
                        onTap: () {},
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
                  height: 100,
                ),





              ]),
        ),
      ),
    );
  }
}
