import 'package:butransit/common/custombutton.dart';
import 'package:butransit/common/customtextfie.dart';
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/auth/screen/phoneverifi.dart';
import 'package:butransit/features/driver/screen/vehiclereport.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/driverservice.dart';

class LoginDriverScreen extends StatefulWidget {
  static const String routeName = '/rloginfordiverscreen';
  const LoginDriverScreen({super.key});

  @override
  State<LoginDriverScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginDriverScreen> {
  final _addkeytologin = GlobalKey<FormState>();

  final countryPicker = const FlCountryCodePicker();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonenumbercontroller = TextEditingController();


  final DriverService driverService = DriverService();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phonenumbercontroller.dispose();
    _passwordController.dispose();
  }

  void loginDriver(){
    driverService.LoginDriver(
      context: context,
      phone_no: _phonenumbercontroller.text, password: _passwordController.text,
    );
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
                Text("Login", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),),
                Text("for driver",
                    style: TextStyle(fontSize: 20, color: Colors.grey)),

                SizedBox(height: 20,),
                Form(
                    key: _addkeytologin,
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        CustomTextfield(controller: _phonenumbercontroller, hintext: "Phone number"),
                      SizedBox(height: 12,),
                      PasswordFieldState(controller: _passwordController, hintext: "password" ),


                      /*  GestureDetector(onTap: () async {
                          final code = await countryPicker.showPicker(context: context);
                          if(code != null) print(code);
                        },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                              ),
                              child: Text('Show Picker', style: TextStyle(color: Colors.white),),
                            )

                        ,), */
                        SizedBox(height: 25,),
                        CustomButton(
                          onTap: () {
                            if(_addkeytologin.currentState!.validate()){
                              loginDriver();
                            }
                          },
                          text: "Login", color: GlobalVariables.primaryColor,),
                      ],
                    )),
                //Input file

                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
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
                  height: 6,
                ),




              ]),
        ),
      ),
    );
  }
}
