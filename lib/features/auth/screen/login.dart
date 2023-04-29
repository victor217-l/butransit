import 'package:butransit/common/custombutton.dart';
import 'package:butransit/common/customtextfie.dart';
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/features/auth/screen/phoneverifi.dart';
import 'package:butransit/features/auth/screen/registerscreen.dart';
import 'package:butransit/features/auth/screen/healthscreen.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../../model/login_request_model.dart';
import '../../../service/api_service.dart';
import '../../../service/config.dart';
import '../service/registerservice.dart';




class LoginScreen extends StatefulWidget {
  static const String routeName = '/rloginscreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _signInFormKey = GlobalKey<FormState>();


  final countryPicker = const FlCountryCodePicker();

  final RegisterService registerservice = RegisterService();

  final TextEditingController _phonenumbercontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordcontroller.dispose();
    _phonenumbercontroller.dispose();
  }

  void loginStudents() async {
    registerservice.loginStudent(
      password: _passwordcontroller.text,
      phone_no: _phonenumbercontroller.text, context: context,
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
              children: [
                const SizedBox(
                  height: 120,
                ),
                RichText(
                  text: TextSpan(
                      text: "Login",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900],
                      ),
                      children: const [
                        TextSpan(
                            text: "with Email and Phone Number",
                            style: TextStyle(fontSize: 20, color: Colors.white))
                      ]),
                ),
                SizedBox(height: 20,),
                Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        CustomTextfield(controller: _phonenumbercontroller, hintext: "Phone number"),
                        SizedBox(height: 10,),
                        PasswordFieldState(controller: _passwordcontroller, hintext: "password",),
                        SizedBox(height: 25,),
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
              if(_signInFormKey.currentState!.validate()){
                loginStudents();
              }
              await Future.delayed(const Duration(seconds: 50));
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
                : const Text('Submit'),
          ),
        ),
                  ]
                ),
        ),



                       /* CustomButton(
                          onTap: () {
    if(_signInFormKey.currentState!.validate()){
    loginStudents();
    }

    },

                          text: "Login", color: GlobalVariables.primaryColor,), */

                //Input file

                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      const Text("Dont have an account", textAlign: TextAlign.center,),
                      const SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, HealthScreen.routeName);
                        },
                        child: const Text(
                          "Register",
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

               Align(
                 alignment: Alignment.center,
                 child:  Text(
                      "Terms and conditions", textAlign: TextAlign.center,

                    ),

               ),



              ]
        ),
      )
        )
    );
  }
}


class LoginScreen1 extends StatefulWidget {
  static const String routeName = '/rloginseen';
  const LoginScreen1({Key? key}) : super(key: key);
  @override
  _LoginScreen1State createState() => _LoginScreen1State();
}
class _LoginScreen1State extends State<LoginScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(shape: StadiumBorder()),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Future.delayed(const Duration(seconds: 5));
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
                : const Text('Submit'),
          ),
        ),
      ),
    );
  }
}
