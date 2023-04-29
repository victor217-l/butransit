import 'package:butransit/features/driver/services/driverservice.dart';
import 'package:flutter/material.dart';

import '../../../common/globalvariables.dart';
import '../../../common/sizetest.dart';
import '../../../model/listofdriver.dart';

class DriverRide extends StatefulWidget {
  static const String routeName = '/driverlist';
  const DriverRide({Key? key}) : super(key: key);

  @override
  State<DriverRide> createState() => _DriverRideState();
}

class _DriverRideState extends State<DriverRide> {

  final DriverService driverService = DriverService();

  @override
  void initState() {
    // TODO: implement initState
    fetchListOfRides();
    super.initState();

  }
  List<Ride>? _driverRides;
  Future<void> fetchListOfRides() async {
    _driverRides = await driverService.fetchListOfRides(context);
    setState(() {

    });
  }

  void logout(){
    driverService.logoutfordriver(context);
  }

  void cancel(Ride ride, int index) async {
    driverService.cancelRidefordriver(context: context,  ride: ride,
        onSuccess: () {
          _driverRides!.removeAt(index);
          setState(() {});
        });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: GlobalVariables.primaryColor
              ),
            ),
            title: const Text(
              'List of rides for drivers',
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
      ),
       body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:   BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child:   _driverRides == null ? Center(child: CircularProgressIndicator())  :
              ListView.builder( itemCount: _driverRides!.length,
                  itemBuilder: (context, index) {
                    final driverDataRides = _driverRides![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 7,),
                        SizedBox(height: 6,),
                        Container(
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
                                horizontal: 16.0,),
                              child: Row(
                                children: [
                                  Image.asset("image/lady-riding-yellow.png",
                                    height: 70, width:60, fit: BoxFit.fill,),
                                  SizedBox(width: 3,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(driverDataRides.currentRideState, style: TextStyle(
                                          color: GlobalVariables.primaryColor),),
                                      SizedBox(height: 6,),
                                      Text(driverDataRides.currentLocation),
                                      GestureDetector(onTap: () {
                                        cancel(driverDataRides, index);
                                      },
                                        child: SizedText(color: GlobalVariables.primaryColor
                                          , text: 'Cancel Ride', ),)
                                    ],),
                                  Expanded(child: Column(
                                    children: [
                                      Text( driverDataRides.destination, style: TextStyle(
                                          color: GlobalVariables.primaryColor),),
                                      SizedBox(height: 12,),
                                      Text(driverDataRides.rideVehicle  , style: TextStyle(
                                          color: Colors.grey),),
                                    ],
                                  )),

                                ],
                              )

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
        child:  Icon(Icons.logout_rounded, size: 12, color: Colors.white,),
        onPressed: () {
          logout();
        },
        tooltip: 'Logout',
      ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.endFloat,
    );







  }
}
