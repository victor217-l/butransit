import 'package:butransit/features/map/services/mapservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/customtextfie.dart';
import '../../../common/globalvariables.dart';
import '../../../common/locations.dart';
import '../../../model/fordriver_model.dart';
import '../../auth/screen/registerscreen.dart';

class AmbulanceDetailWitness extends StatefulWidget {
  static const String routeName = '/ambulancforwith';

  const AmbulanceDetailWitness({Key? key, }) : super(key: key);

  @override
  State<AmbulanceDetailWitness> createState() => _AmbulanceDetailWitnessState();
}

class _AmbulanceDetailWitnessState extends State<AmbulanceDetailWitness> {

  final _AmbulanceDetail = GlobalKey<FormState>();

  final TextEditingController _victiomController = TextEditingController();
  final TextEditingController _severtityController = TextEditingController();
  final TextEditingController _currentlocationController = TextEditingController();

  final MapService mapService = MapService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _severtityController.dispose();
    _victiomController.dispose();
    _currentlocationController.dispose();
  }

  void callAmbulanceforwitness() async {
    mapService.Ambulancedetforwitness(context: context, current_location: _currentlocationController.text,
        victim_name: _victiomController.text, emergency_desc:  _severtityController.text);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:   BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key:  _AmbulanceDetail,
                child: Column(
                  children: [
                    SizedBox(height: 20,),

                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Ambulance is arriving soon", style: TextStyle(
                          color:GlobalVariables.primaryColor, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Victim", style: TextStyle(
                            color:GlobalVariables.primaryColor, fontWeight: FontWeight.bold),),
                        SizedBox(width: 15,),
                        Column(
                          children: [
                            Text("Witness", style: TextStyle(
                                color:GlobalVariables.primaryColor, fontWeight: FontWeight.bold),),
                            SizedBox(height: 1,),
                            Container(
                              height: 3,
                              width: 60,
                              decoration: BoxDecoration(
                                color: GlobalVariables.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                          ],
                        )

                      ],

                    ),
                    SizedBox(height: 40,),
                    CustomTextfield(controller: _victiomController , hintext: "victim name"),


                    SizedBox(height: 35,),
                    CustomTextfieldforAmbulance(controller: _severtityController, hintext: 'State the problem',),

                    SizedBox(height: 35,),
                    CustomTextfield(controller: _currentlocationController , hintext: "location method"),



                    SizedBox(height: 12,),
                    Center(
                      child: GestureDetector(onTap: () =>   RegisterScreen.routeName,
                        child: Text("Cancel Ride", style: TextStyle(color: Colors.red),) ,),
                    ),
                    SizedBox(height: 4,),
                    //  CustomButton(onTap: () => , text: "Book Ride")
                    Container(
                      height: 70,
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          )
                      ), child :
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          if(_AmbulanceDetail.currentState!.validate()){
                            callAmbulanceforwitness();
                          }
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: GlobalVariables.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text("Apply", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ) ,
                    ),
                    ),
                    SizedBox(height: 10,),





                  ],
                ),
              ),
            ),
          ),
        ),
      ),);


  }
}




