import 'package:butransit/common/custombutton.dart';
import 'package:butransit/common/customtextfie.dart';
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/driver/screen/loginfordeiver.dart';
import 'package:butransit/features/driver/screen/vehiclereport.dart';
import 'package:butransit/features/driver/services/driverservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterDriverScreen extends StatefulWidget {
  static const String routeName = '/fordriver';
  const RegisterDriverScreen({super.key});

  @override
  State<RegisterDriverScreen> createState() => _RegisterDriverScreenState();
}

class _RegisterDriverScreenState extends State<RegisterDriverScreen> {
  final _addkeytodriverregister = GlobalKey<FormState>();

  final DriverService driverService = DriverService();

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _phonenumberController.dispose();
  }

  void registerDriver(){
    driverService.RegisterDriver(
      context: context,
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      phone_no: _phonenumberController.text,
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
            Text("Register", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900],
            ),),
                Text("for driver",
        style: TextStyle(fontSize: 20, color: Colors.grey)),

            SizedBox(height: 20,),
            Form(
                key: _addkeytodriverregister,
                child: Column(
                  children: [
                    CustomTextfield(
                        controller: _emailcontroller,
                        hintext: "email@gmail.com"),
                    const SizedBox(
                      height: 20,
                    ),
                    PasswordFieldState(controller: _passwordcontroller, hintext: "Password",),
                    //Input
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                        controller: _phonenumberController,
                        hintext: "Phone number"),
                    const SizedBox(
                      height: 70,
                    ),
                    CustomButton(
                        onTap: () {
                          if(_addkeytodriverregister.currentState!.validate()){
                            registerDriver();
                          }
                        },
                        text: "Next", color: GlobalVariables.primaryColor,),
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
                        onTap:(){ Navigator.pushNamed(context, LoginDriverScreen.routeName); },
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
              height: 70,
            ),




          ]),
        ),
      ),
    );
  }
}
