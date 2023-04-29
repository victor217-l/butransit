import 'package:butransit/common/custombutton.dart';
import 'package:butransit/common/customtextfie.dart';
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/driver/services/driverservice.dart';
import 'package:butransit/features/map/screen/mapscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../../main.dart';

class Phoneverificationfordriver extends StatefulWidget {
  static const String routeName = "/phoneverification";
  const Phoneverificationfordriver({super.key});

  @override
  State<Phoneverificationfordriver> createState() => _PhoneverificationfordriverState();
}

class _PhoneverificationfordriverState extends State<Phoneverificationfordriver> {

  final _otpkey = GlobalKey<FormState>();

  final TextEditingController _phoneverificationfordriver = TextEditingController();

  final DriverService driverService = DriverService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneverificationfordriver.dispose();
  }

  void otpverification(){
    driverService.otpVerificatonForDrivers(context: context,
        code: _phoneverificationfordriver.text,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _otpkey,
              child: Column(

                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Text(
                    "Phone Verification",
                     textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.primaryColor),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "We have sent an SMS code to verify your number",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Enter code here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                   CustomTextfield(controller: _phoneverificationfordriver , hintext: "otp"),
                  SizedBox(height: 12,),
                  MaterialButton(
                    onPressed: () {
                      if(_otpkey.currentState!.validate()){
                        otpverification();
                      }
                    },
                    color: GlobalVariables.primaryColor,
                    minWidth: double.infinity,
                    height: 50,
                    child: Center(child: Text("Enter", style: TextStyle(color: Colors.white),)),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Did not receive code ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Resend(31e)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.primaryColor),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  CustomButton(
                      onTap: () {
                        Navigator.pushNamed(context, MapScreen.routeName);
                      },
                      text: "To map", color: GlobalVariables.primaryColor,)
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
