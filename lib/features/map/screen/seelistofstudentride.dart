import 'package:butransit/features/driver/services/driverservice.dart';
import 'package:butransit/features/map/services/mapservice.dart';
import 'package:butransit/model/forstudent_model.dart';
import 'package:flutter/material.dart';

import '../../../common/globalvariables.dart';
import '../../../common/sizetest.dart';
import '../../../model/listofdriver.dart';

class StudentListRide extends StatefulWidget {
  static const String routeName = '/studentlist';
  const StudentListRide({Key? key}) : super(key: key);

  @override
  State<StudentListRide> createState() => _StudentListRideState();
}

class _StudentListRideState extends State<StudentListRide> {

  final MapService mapService = MapService();


  void logout(){
    mapService.logout(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    allistofstudent();
    super.initState();

  }



  List<RideForStudent>? listofride;

  Future<void> allistofstudent() async {
    listofride = await mapService.fetchlistofstudent(context);
    setState(() {

    });
  }



  void cancel(RideForStudent rideForStudent, int index) async {
    mapService.cancelRide(context: context,  rideForStudent: rideForStudent,
        onSuccess: () {
          listofride!.removeAt(index);
          setState(() {});
        });
  }






  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
    onRefresh: allistofstudent,
      child: Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: GlobalVariables.primaryColor
                ),
              ),
              title: const Text(
                'List of rides',
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
        ),
        body:  SafeArea(
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:   BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: listofride == null ? Center(child: CircularProgressIndicator(),) :
              ListView.builder( itemCount: listofride!.length,
                  itemBuilder: (context, index) {
                    final StudentDataRides = listofride![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              border: Border.all(
                                color: GlobalVariables.primaryColor,
                                width: 1,
                              )
                            ),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10),
                                child: Row(
                                  children: [
                                    Image.asset("image/lady-riding-yellow.png",
                                      height: 70, width:60, fit: BoxFit.fill,),
                                    SizedBox(width: 3,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(StudentDataRides.currentRideState, style: TextStyle(
                                            color: GlobalVariables.primaryColor),),
                                        SizedBox(height: 2,),
                                        Text(StudentDataRides.currentLocation),
                                        SizedBox(height: 2,),
                                        GestureDetector(onTap: () {
                                          cancel(StudentDataRides, index);
                                        },
                                          child: SizedText(color: GlobalVariables.primaryColor
                                            , text: 'Cancel Ride', ),)
                                    ]),
                                    SizedBox(width: 60,),
                                    Expanded(child: Column(
                                      children: [
                                        Text( StudentDataRides.destination, style: TextStyle(
                                            color: GlobalVariables.primaryColor),),
                                        SizedBox(height: 12,),
                                        Text(StudentDataRides.rideVehicle  , style: TextStyle(
                                            color: Colors.grey),),
                                      ],
                                    )),



                                  ],
                                )


                            ),
                          ),
                        ),

//  CustomButton(onTap: () =>, text: "Book Ride")
                        /*  Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                  )
                              ), child:
                            Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: GestureDetector(
                                onTap:() { Navigator.pushNamed(context, DriveDetail.routeName,
                                    arguments: _drivers![index]); },
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
                              ),
                            ),
                            ) */
                      ],
                    );
                  }
              ),
            ),
        ),

        floatingActionButton: FloatingActionButton(
          child:  Icon(Icons.logout, color: GlobalVariables.primaryColor,),
          onPressed: () {
            logout();
          },
          tooltip: 'Logout',
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.endFloat,
      ),
    );







  }
}
