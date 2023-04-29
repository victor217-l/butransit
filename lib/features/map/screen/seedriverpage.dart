import 'package:butransit/common/custombutton.dart';
import 'package:butransit/features/map/screen/seelistofstudentride.dart';
import 'package:butransit/features/map/services/mapservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/customtextfie.dart';
import '../../../common/globalvariables.dart';
import '../../../common/locations.dart';
import '../../../model/fordriver_model.dart';
import '../../../model/listofdriver.dart';
import '../../auth/screen/registerscreen.dart';

class DriveDetail extends StatefulWidget {
  static const String routeName = '/driverpage';
  final Driver driver;
  const DriveDetail({Key? key, required this.driver}) : super(key: key);

  @override
  State<DriveDetail> createState() => _DriveDetailState();
}


class _DriveDetailState extends State<DriveDetail> {

 // final TextEditingController _paymentController = TextEditingController();

  final TextEditingController _paymentcontroller = TextEditingController();
  final TextEditingController _paymCvcontroller = TextEditingController();
  final TextEditingController _payexpiringmonthcontroller = TextEditingController();
  final TextEditingController _payexpiringyearcontroller = TextEditingController();

  final MapService mapService = MapService();







  Future<void> showInformation(BuildContext context) async {
    return await showDialog(context: context, builder: (context) {

      Future<void> _saveData(List<String> data)  async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('bank_detail', data);
      }






      bool isChecked = false;

      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Form(child: Column(
              children: [
                TextFormField(
                  controller: _paymentcontroller,
                  validator: (value){
                    return value!.isNotEmpty ? null : 'invalid Field';
                  },
                  decoration: InputDecoration(hintText: 'Enter card number', labelText: 'Input 1',),
                ),
                SizedBox(height: 12,),
                TextFormField(
                  controller: _paymCvcontroller,
                  validator: (value){
                    return value!.isNotEmpty ? null : 'invalid Field';
                  },
                  decoration: InputDecoration(hintText: 'Enter CV number'),
                ),
                SizedBox(height: 12,),
                TextFormField(
                  controller: _payexpiringmonthcontroller,
                  validator: (value){
                    return value!.isNotEmpty ? null : 'invalid Field';
                  },
                  decoration: InputDecoration(hintText: 'Enter Expiring month'),
                ),
                SizedBox(height: 12,),
                SizedBox(height: 12,),
                TextFormField(
                  controller: _payexpiringyearcontroller,
                  validator: (value){
                    return value!.isNotEmpty ? null : 'invalid Field';
                  },
                  decoration: InputDecoration(hintText: 'Enter Expiring year'),
                ),
                SizedBox(height: 12,),
                CustomButton(onTap: () async {
                  List<String> data = [
                    _paymentcontroller.text,
                    _payexpiringmonthcontroller.text,
                    _paymCvcontroller.text,
                    _payexpiringyearcontroller.text,
                  ];
                  _saveData(data);

                  Navigator.of(context).pop();

                }, text: 'Enter Card details'),

              ],
            )),
          ),
        );

      }

      );

    }
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _location();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _payexpiringmonthcontroller.dispose();
    _payexpiringyearcontroller.dispose();
    _paymentcontroller.dispose();
    _paymCvcontroller.dispose();
  }
  
  
  void bookrRide() async {
    mapService.bookRide(context: context, current_location: location,
      dropoff_location: location, arival_time: "3",
      ride_time: "1", driver_id: "3",
      card_exp_month: _payexpiringmonthcontroller.text,
      card_exp_year: _payexpiringyearcontroller.text,
      card_cvv: _paymCvcontroller.text,
      card_no: _paymentcontroller.text,

    );
  }

  final _addtokey = GlobalKey<FormState>();


  void logout() async {
    mapService.logout(context);
  }

   String location = '';

  _location() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      location = ( prefs.getString('location') ?? '');
    });
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
              key: _addtokey,
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  const SizedBox(
                    height: 20,
                  ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 60,
                              width: 60,
                              child:  Image.network(widget.driver.profileImage, fit: BoxFit.fill,),
                            ),
                          ),

                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Text(widget.driver.name, style: TextStyle(fontSize: 20),),
                      SizedBox(height: 2,),
                      Text("plate number: ${widget.driver.plateNumber}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.my_location_outlined,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pick up", textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey),

                          ),
                          SizedBox(height: 2,),
                          Text(
                            "My current location",
                            style: TextStyle(
                                color: GlobalVariables
                                    .primaryColor),
                          )
                        ],
                      )

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Drop off",
                            style:
                            TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 5,),

                          Text(location, style: TextStyle(color: GlobalVariables.primaryColor),
                          ) ,
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Price:", style: TextStyle(
                          color:GlobalVariables.primaryColor, fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Expanded(child: Text("${widget.driver.ridePrice}", style: TextStyle(
                          color:GlobalVariables.primaryColor) )),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () async {
                        await showInformation(context);
                      },
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          color: GlobalVariables.primaryColor,
                        ),
                        child: Center(
                          child: Text("Payment method", style: TextStyle(color: Colors.white, fontSize: 8 ),),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(onTap: () {
                      Navigator.pushNamed(context, StudentListRide.routeName);
                    },
                      child: Text("List of student Ride", style: TextStyle(color: Colors.blue),) ,),
                  ),
                  SizedBox(height: 12,),

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
                      //  if(_addtokey.currentState!.validate()){
                          bookrRide();
                      //  }

                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: GlobalVariables.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text("Book Ride", style: TextStyle(color: Colors.white)),
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




