import 'dart:convert';

import 'package:butransit/common/custombutton.dart';
import 'package:butransit/common/customtextfie.dart';
import 'package:butransit/common/globalvariables.dart';
import 'package:butransit/common/locations.dart';
import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/map/screen/ambulance.dart';
import 'package:butransit/features/map/screen/seedriverpage.dart';
import 'package:butransit/features/map/services/mapservice.dart';
import 'package:butransit/model/fordriver_model.dart';
import 'package:butransit/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart' hide  LatLng;
import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart' as LatLng;


import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/screen/registerscreen.dart';


class MapScreen extends StatefulWidget {
  static const String routeName = "/mapscreen";


  late Position position;
  bool isLoad = false;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>  with TickerProviderStateMixin{

  final PopupController _popupcontroller = PopupController();
  final MapController _mapController = MapController();
  
  final MapService mapService = MapService();

  final TextEditingController _dropoffcontroller = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  







  Future<void> getCurrentPositions() async {
    widget.position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      widget.isLoad = true;
    });
  }

    List<Marker> setmarkers = [




  Marker(
  anchorPos: AnchorPos.align(AnchorAlign.center),
  height: 30,
  width: 30,
  point: LatLng.LatLng(6.8921, 3.7181),
  builder: (ctx) => Icon(Icons.pin_drop),
  ),
  Marker(
  anchorPos: AnchorPos.align(AnchorAlign.center),
  height: 30,
  width: 30,
  point: LatLng.LatLng(6.8021, 3.7582),
  builder: (ctx) => Icon(Icons.pin_drop),
  ),
  Marker(
  anchorPos: AnchorPos.align(AnchorAlign.center),
  height: 30,
  width: 30,
  point: LatLng.LatLng(6.89160990182, 3.72486575064 ),
  builder: (ctx) => Icon(Icons.pin_drop),
  ) ,
  Marker(
  anchorPos: AnchorPos.align(AnchorAlign.center),
  height: 30,
  width: 30,
  point: LatLng.LatLng(6.891, 3.711),
  builder: (ctx) => Icon(Icons.pin_drop),
  ),
  Marker(
  anchorPos: AnchorPos.align(AnchorAlign.center),
  height: 30,
  width: 30,
  point: LatLng.LatLng(6.8421, 3.7281),
  builder: (ctx) => Icon(Icons.pin_drop),
  ),


  ];


   @override
  void initState() {
    // TODO: implement initState
     getCurrentPositions();
    // pointIndex = 0;
     _loadCounter();
     fetchAllProducts();
    super.initState();
  }



  String firstPlace = 'SAT';


  List<String> placesTogo = [
    'SAT',
    'BGH',
    'BUTH',
    'Akande hall',
    'Ameyo hall',
    'Bethel hall',
    'FAD hall',
    'stadium',
    'BBS',
    'BUTH GATE',
    'Babcock shopping ',
  ];

  //fourth page
  double rideDetailsContainer = 0;
  //first page
  double  searchContainerHeight = 170;
  //second page
  double searchContainerHeight2 = 0;
  //for thir adminstrator page
  //top container
  double seeminpagesheight = 0;
  double seeminpageweight = 0;
  //for bottom sheet
  double blurradius = 0;
  double spreadraduis = 0;
  double bottomsheet = 0;
  //for apply container
  double forapplyheight= 0;
  double forapplywidth =0;
  //fifth page//
  double seedriversheight = 0;

  void displayRideDetailsContainer() async {
    _mapService.searchLocation(context: context,
        search: _wheretocontroller.text);
    setState(() {
      searchContainerHeight = 0;
      //rideDetailsContainer = 240;
       searchContainerHeight2 = 300;

    });
  }

  void adminpageheightweight() async {
    setState(() {
      _loadCounter();

       rideDetailsContainer = 0;
        searchContainerHeight = 0;
       searchContainerHeight2 = 0;
       //for top container
       seeminpagesheight = 60;
       seeminpageweight = 100;
       //for bottom sheet
       bottomsheet = 70;
      //for apply container
      forapplyheight= 30;
      forapplywidth=50;

    });
  }



  void seepagesheight2() async  {
     setState(() {

       fetchAllProducts();
       seeminpagesheight = 0;
       seeminpageweight = 0;
       //for bottom sheet
       bottomsheet = 0;
       blurradius =  6.0;
       spreadraduis = 5.0;
       //for apply container
       forapplyheight= 0;
       forapplywidth=0;
       searchContainerHeight = 0;
       rideDetailsContainer = 360;
       searchContainerHeight2 = 0;

     });
  }

  void seedriverspage() async {
    setState(() {
      _loadCounter();
      seeminpagesheight = 0;
      seeminpageweight = 0;
      //for bottom sheet
      blurradius =  0;
      spreadraduis = 0;
      bottomsheet = 0;
      //for apply container
      forapplyheight= 0;
      forapplywidth=0;
      searchContainerHeight2 = 0;
      seedriversheight =  500;
      searchContainerHeight = 0;


    });
  }

  final TextEditingController _wheretocontroller = TextEditingController();
  final TextEditingController _whereyouarecontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _wheretocontroller.dispose();
    _whereyouarecontroller.dispose();
  }

  final MapService _mapService = MapService();

  void searchLocation() {
    _mapService.searchLocation(context: context,
        search: _wheretocontroller.text);
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      location_name = (prefs.getString('location') ?? '');
    });
  }

  _savefile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
   //   _whereyouarecontroller = ()
    });
  }

  //String _whereyouarecontroller = '';

  String location_name = '';

  List<Driver>? _drivers;
  Future<void>  fetchAllProducts() async {
    _drivers = await mapService.fetchAlldriversavailble(context);
  /*  final response = await http.get(Uri.parse(
        'https://babcock-transit.onrender.com/api/v1/student/fetch-available-drivers'));
    final data = json.decode(response.body);
    final drivers = (data['result'] as List).map((json) => Driver.fromJson(json)).toList();
    setState(() {
      _drivers = drivers;
    });

    print(response.body); */
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;
    return Scaffold(


        body:    SafeArea(
          child: Stack(
            children: [
              Positioned(child: widget.isLoad
                  ? FlutterMap(
                mapController: _mapController,
                  options: MapOptions(
                    center: LatLng.LatLng(widget.position.latitude, widget.position.longitude),
                    zoom: 5,
                    plugins: [
                      LocationMarkerPlugin(),
                      MarkerClusterPlugin(),
                    ],
                    // onTap: (_) => _popupcontroller.hideAllPopups(),
                  ),
                  layers : [
                    TileLayerOptions(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(point: new LatLng.LatLng(
                        widget.position.latitude, widget.position.longitude),
                            builder: (context) => new Icon(Icons.my_location_outlined, color: Colors.green,))
                      ]
                    ),
                    MarkerClusterLayerOptions(
                        maxClusterRadius: 120,
                        disableClusteringAtZoom: 6,
                        size: Size(40, 40),
                        anchor: AnchorPos.align(AnchorAlign.center),
                        fitBoundsOptions: FitBoundsOptions(
                            padding: EdgeInsets.all(50)
                        ),
                        markers: setmarkers,
                        polygonOptions: PolygonOptions(
                            borderColor: GlobalVariables.primaryColor,
                            color: Colors.black12,
                            borderStrokeWidth: 3),
                        popupOptions: PopupOptions(
                          popupSnap: PopupSnap.markerTop,
                          popupController: _popupcontroller,
                          popupBuilder: (_,marker) => Container(
                            width: 200,
                            height: 100,
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () => debugPrint("Popup tap"),
                              child: Text(
                                  "Container popup for marker at ${marker.point}"
                              ),
                            ),
                          ),
                        ),
                        builder: (context, markers) {

                          return FloatingActionButton(

                              child:  Text(markers.length.toString()),
                              onPressed: null
                          );
                        }
                    )


                  ]

              ) : const Center(child: CircularProgressIndicator())
              ),
             Positioned(
                right:0,
                left: 0,
                bottom: 0,
                  child: AnimatedSize(
                    vsync: this,
                    curve: Curves.bounceIn,
                    duration: new Duration(milliseconds: 160),
                    child: Container(
                      width: double.infinity,
                      height: searchContainerHeight,
                      decoration: BoxDecoration(
                          color: Colors.white,
                        borderRadius:   BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                         //   Text(userProvider.token,style: TextStyle(fontSize: 12, color: Colors.brown),),
                            SizedBox(height: 2 ,),
                            Center(
                              child: Container(
                                height: 3,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: GlobalVariables.primaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
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
                              height: 10,
                            ),
                      /*     Row(
                              children: [
                                Icon(
                                  Icons.my_location_outlined,
                                  color: GlobalVariables.primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "The place you are", textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.grey),

                                    ),
                                    SizedBox(height: 5,),
                                    SizedBox(width: 230, height: 30,
                                        child: Center(child:
                                        WhereTo(hintext:"Where to", controller: _whereyouarecontroller,))),

                                  ],
                                )

                              ],
                            ), */
                            SizedBox(
                              height: 10,
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
                                      height: 5,),
                                     Row(
                                       children: [

                                         SizedBox(width: 230, height: 30,
                                             child: Center(child:  CustomTextfiel(controller: _wheretocontroller,
                                             hintext: 'where to',),

                                             )),
                                          SizedBox(width: 2,),

                                         GestureDetector(
                                             onTap: () {
                                               displayRideDetailsContainer();
                                             },
                                             child: Icon(Icons.search, size: 20, color: Colors.grey)),



                                       ]
                                     )



                                          //  CustomTextfield(controller:  , hintext: "where to",)
                                      //  WhereTo(hintext:"Where to", controller: _wheretocontroller,)

                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedSize(
                  vsync: this,
                  curve: Curves.bounceIn,
                  duration: new Duration(milliseconds: 160),
                  child:
                     Container(
                      width: double.infinity,
                      height: searchContainerHeight2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:   BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2 ,),
                          Center(
                            child: Container(
                              height: 3,
                              width: 60,
                              decoration: BoxDecoration(
                                color: GlobalVariables.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
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
                            height: 6,
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
                                  GestureDetector(
                                    onTap: _loadCounter,
                                    child: Text(
                                      "Drop off",
                                      style:
                                      TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3, ),

                                    GestureDetector(
                                      onTap:  adminpageheightweight,
                                      child: Text(location_name, style: TextStyle(
                                            color: GlobalVariables
                                                .primaryColor) ),
                                    ),

                                  SizedBox(height: 10 ,),

                                ],
                              )
                            ],
                          ),
                          Container(
                            height: 4,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Text("POPULAR LOCATION", style: TextStyle(
                                    color: GlobalVariables
                                        .primaryColor) ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 2,),
                                    Text("Sat",style: TextStyle(
                                        color: Colors.black), ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 2,),
                                    Text("Bucodel",style: TextStyle(
                                        color: Colors.black), ),
                                  ],
                                ),
                          /*      Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 2,),
                                    Text("Sat",style: TextStyle(
                                        color: Colors.black), ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 2,),
                                    Text("Sat",style: TextStyle(
                                        color: Colors.black), ),
                                  ],
                                ), */
                              ],
                            ),
                          )

                        ],
                      ),
                    ),

                  ),
                ), ),
              Positioned(
                child: AnimatedSize(
      vsync: this,
      curve: Curves.bounceIn,
      duration: new Duration(milliseconds: 160),
                  child: Stack(children: [
                  Positioned(
                    top: 50,
                    right: 10,
                    left: 10,
                    child: Container(
                      height: seeminpagesheight,
                      width: seeminpageweight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                       /* boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: blurradius,
                            spreadRadius: spreadraduis,
                            offset: Offset(0.7,0.7)
                          )
                        ] */
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed : () {
                              Navigator.pushNamed(context, LoginScreen.routeName);
                            },
                         icon: Icon(Icons.arrow_back, color: Colors.grey,)),
                          SizedBox(width: 3,),
                          Text(location_name),
                        ],
                      ),
                    ),
                  ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                       height: bottomsheet,
                       decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        )
                      ),
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                         child: GestureDetector(
                           onTap: seepagesheight2,
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
                    ),
              ],),
                )),

              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AnimatedSize(
                    vsync:this,
                    curve: Curves.bounceIn ,
                    duration: new Duration(milliseconds: 200),
                    child: Container(
                      height: rideDetailsContainer,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7)
                            )
                          ]
                      ),
                      child: _drivers == null ? Center(child: CircularProgressIndicator())  :
                      ListView.builder( itemCount: _drivers!.length,
      itemBuilder: (context, index) {
        final driverData = _drivers![index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                  color: GlobalVariables.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            SizedBox(height: 7,),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("SELECT YOUR RIDE?", style: TextStyle(
                  color: Colors.grey),),
            ),
            SizedBox(height: 6,),
            Container(
              width: double.infinity,
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
                          Text(driverData.name, style: TextStyle(
                              color: GlobalVariables.primaryColor),),
                          SizedBox(height: 6,),
                          Text("Free(3 personal)")
                        ],),
                      Expanded(child: Column(
                        children: [
                          Text(' ${driverData.ridePrice}', style: TextStyle(
                              color: GlobalVariables.primaryColor),),
                          SizedBox(height: 12,),
                          Text("${driverData.arrivalTime}  mins", style: TextStyle(
                              color: Colors.grey),),
                        ],
                      )),

                    ],
                  )

              ),
            ),

            //  CustomButton(onTap: () =>, text: "Book Ride")
            Container(
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
            )
          ],
        );
      }
      ),

                    ),
                  ) ),

             /* Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 3,
                      width: 60,
                      decoration: BoxDecoration(
                        color: GlobalVariables.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: 7,),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("SELECT YOUR SIDE?",style: TextStyle(
                        color: Colors.grey), ),
                  ),
                  SizedBox(height: 6,),
                  Container(
                    width: double.infinity ,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,),
                        child: Row(
                          children: [
                            Image.asset("image/lady-riding-yellow.png",
                              height: 10, width: 10, fit: BoxFit.fill,),
                            SizedBox(width: 3,),
                            Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text("Dan jao", style: TextStyle(
                                    color: GlobalVariables.primaryColor),),
                                SizedBox(height: 6,),
                                Text("Free(3 personal)")
                              ],),
                            Expanded(child: Column(
                              children: [
                                Text("250", style: TextStyle(
                                    color: GlobalVariables.primaryColor),),
                                SizedBox(height: 12,),
                                Text("3 mins", style: TextStyle(
                                    color: Colors.grey),),
                              ],
                            )),

                          ],
                        )

                    ),
                  ),
                  Container(
                    width: double.infinity ,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,),
                        child: Row(
                          children: [
                            Image.asset("image/lady-riding-yellow.png", height: 10, width: 10,  fit: BoxFit.fill,),
                            SizedBox(width: 3,),
                            Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text("Dan jao", style: TextStyle(
                                    color: GlobalVariables.primaryColor),),
                                SizedBox(height: 8,),
                                Text("Free(3 personal)")
                              ],),
                            Expanded(child: Column(
                              children: [
                                Text("250", style: TextStyle(
                                    color: GlobalVariables.primaryColor),),
                                SizedBox(height: 12,),
                                Text("3 mins", style: TextStyle(
                                    color: Colors.grey),),
                              ],
                            )),

                          ],
                        )

                    ),
                  ),
                  Container(
                    width: double.infinity ,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,),
                        child: Row(
                          children: [
                            Image.asset("image/lady-riding-yellow.png",  height: 10, width: 10, fit: BoxFit.contain,),
                            SizedBox(width: 3,),
                            Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text("Dan jao", style: TextStyle(
                                    color: GlobalVariables.primaryColor),),
                                SizedBox(height: 6,),
                                Text("Free(3 personal)")
                              ],),
                            Expanded(child: Column(
                              children: [
                                Text("250", style: TextStyle(
                                    color: GlobalVariables.primaryColor),),
                                SizedBox(height: 12,),
                                Text("3 mins", style: TextStyle(
                                    color: Colors.grey),),
                              ],
                            )),

                          ],
                        )

                    ),
                  ),
                  //  CustomButton(onTap: () =>, text: "Book Ride")
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
                      onTap: seedriverspage,
                      child: Container(
                        height: 30,
                        decorati.on: BoxDecoration(`
                          color: GlobalVariables.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text("Apply", style: TextStyle   (color: Colors.white)),
                        ),
                      ),
                    ) ,
                  ),
                  )
                ],
              ), */


              Positioned(
                top: 30,
                  right: 10,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AmbulanceDetail.routeName);
                        },
                        icon: Icon(Icons.cabin_sharp, size: 12,),
                      ),
                    ) ,
                  ) )
            ],
          ),
        )


      );


  }
}




/*

Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("/asset/images.map")),
              ),
              child: Stack(children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet<dynamic>(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              )),
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.white,
                              builder: (_) {
                                return Container(
                                  height: 179,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 1,
                                          width: 6,
                                          color: GlobalVariables.primaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.my_location_outlined,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "My current location",
                                            style: TextStyle(
                                                color: GlobalVariables
                                                    .primaryColor),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Drop off",
                                                style:
                                                    TextStyle(color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: DropdownButton(
                                                  value: firstPlace,
                                                  icon: const Icon(Icons.keyboard_arrow_down),
                                                  items: placesTogo.map((String item) {
                                                    return DropdownMenuItem(
                                                      value: item,
                                                      child: Text(item),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newVal) {
                                                    setState(() {
                                                      firstPlace = newVal!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.menu)),
                  ),
                ),
              ]),

            ),
          ],
        ),
      ),

*/