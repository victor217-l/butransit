import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/auth/screen/registerscreen.dart';
import 'package:butransit/features/driver/screen/registerscreenfordriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../common/globalvariables.dart';

class Startuppagechose extends StatefulWidget {
  const Startuppagechose({super.key});

  @override
  State<Startuppagechose> createState() => _StartuppagechoseState();
}

class _StartuppagechoseState extends State<Startuppagechose> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                  children: [
                    SizedBox(height: 250,),
                    MaterialButton(onPressed: () {
                      Navigator.pushNamed(context, RegisterDriverScreen.routeName);
                    },
                      color: GlobalVariables.primaryColor,
                      height: 30,
                      child: Center(
                        child: Text("For Drivers", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    SizedBox(height: 5,),
                    MaterialButton(onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                      height: 30,
                      color: GlobalVariables.primaryColor,
                      child: Center(
                        child: Text("For Students", style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    SizedBox(height: 12,),
                  ]

              ),
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