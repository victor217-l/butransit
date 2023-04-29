import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/auth/screen/registerscreen.dart';
import 'package:butransit/features/driver/screen/registerscreenfordriver.dart';
import 'package:butransit/features/startupage/screen/startpagetochoose.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../common/globalvariables.dart';

class Startuppage extends StatefulWidget {
  const Startuppage({super.key});

  @override
  State<Startuppage> createState() => _StartuppageState();
}

class _StartuppageState extends State<Startuppage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Startuppagechose()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: GlobalVariables.primaryColor),
          child: Center(
            child: Stack(
              children: [
                Container(
                  width: 170,
                  decoration: BoxDecoration(
                    color: GlobalVariables.primaryColor,
                  ),
                  child: Stack(children: [
                    RichText(
                      text: TextSpan(
                          text: "Bu",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[900],
                          ),
                          children: const [
                            TextSpan(
                                text: "Transit",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ]),
                    ),
                    Positioned(
                        right: 9,
                        bottom:30 ,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            color: GlobalVariables.secondarycolor,
                          ),
                        ))
                  ]),
                ),
              ]

            ),
          )
      ),
    );
  }
}
/*
2020 by Luljosh
Atlantis(Extra sped up) by seafret sped up + slowed
this side of paradise by coyote theory
everbody wants to rule by
chandeleir by will paquincha
 */