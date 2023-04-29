import 'package:butransit/common/custombutton.dart';
import 'package:butransit/common/customtextfie.dart';
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/auth/service/registerservice.dart';
import 'package:butransit/features/driver/screen/registerscreenfordriver.dart';
import 'package:butransit/features/driver/screen/vehiclereport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'healthscreen.dart';
import '../../map/screen/mapscreen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/registerscreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _addkeytoregister = GlobalKey<FormState>();

  final RegisterService registerservice = RegisterService();


  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonenumbercontroller = TextEditingController();
  final TextEditingController _matricnumcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _phonenumbercontroller.dispose();
    _matricnumcontroller.dispose();
  }

  void registerStudent(){
    registerservice.RegisterStudent(
      context: context,
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      phone_no: _phonenumbercontroller.text,
      matric_no : _matricnumcontroller.text,
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              const SizedBox(
                height: 50,
              ),
                      Text("Register", style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900],
                      ),),
                      Text("for student",
                          style: TextStyle(fontSize: 15, color: Colors.grey)),

                      SizedBox(height: 30,),
              Form(
                  key: _addkeytoregister,
                  child: Column(
                    children: [
                      CustomTextfield(
                          controller: _emailcontroller,
                          hintext: "email@gmail.com"),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordFieldState(controller: _passwordcontroller, hintext: "Password",),
                      //Input
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(controller: _phonenumbercontroller, hintext: "Number"),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(controller: _matricnumcontroller, hintext: "matric"),
                      const SizedBox(
                        height: 50,
                      ),

                      CustomButton(
                          onTap: () {
                            if(_addkeytoregister.currentState!.validate()){
                              registerStudent();
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
                     padding: const EdgeInsets.only(left: 70),
                     child: Row(
                      children: [
                        const Text("Already have an account?", textAlign: TextAlign.center,),
                       // const Text("Register for driver", textAlign: TextAlign.center,),
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





            ]),

          ),


        ),
      ),
    );
  }
}
