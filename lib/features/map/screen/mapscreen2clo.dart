import 'package:butransit/common/custombutton.dart';
import 'package:butransit/common/customtextfie.dart';
import 'package:butransit/common/globalvariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart' hide  LatLng;

import 'package:latlong2/latlong.dart' as LatLng;


import 'package:geolocator/geolocator.dart';

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

  final TextEditingController _dropoffcontroller = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();


  double rideDetailsContainer = 0;
  double  searchContainerHeight = 170;

  void displayRideDetailsContainer() async {
    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainer = 240;

    });
  }



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


  @override
  Widget build(BuildContext context) {
    return Scaffold(





        body:   SafeArea(
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
                            borderColor: Colors.blueAccent,
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
                  top: 20,
                  left: 10,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      onPressed:
                          () {
                        showModalBottomSheet(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                )),
                            isScrollControlled: true,
                            context: context,

                            builder: (_) {
                              return Stack(
                                children: [
                                  Positioned(

                                    child: AnimatedSize(
                                      vsync:this,
                                      curve: Curves.bounceIn ,
                                      duration: new Duration(milliseconds: 160),
                                      child: Container(
                                        width: double.infinity,
                                        height: searchContainerHeight,
                                        color: Colors.white,

                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(

                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 12,),
                                              Center(
                                                child: Container(
                                                  height: 5,
                                                  width: 26,
                                                  color: GlobalVariables.primaryColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.my_location_outlined,
                                                    color: Colors.green,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Pick up",
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
                                                    width: 4,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Drop off",
                                                        style:
                                                        TextStyle(color: Colors.grey),
                                                      ),
                                                      SizedBox(
                                                          width: 3,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: GestureDetector(
                                                                onTap: () {

                                                                },
                                                                child: CustomTextfield(hintext: "where to", controller: _paymentController,)
                                                            ) ,
                                                          )
                                                      ),


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

                                  Positioned(child: Container(
                                    width: double.infinity,
                                    height: 400,
                                    color: Colors.white,

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 12,),
                                          Center(
                                            child: Container(
                                              height: 5,
                                              width: 26,
                                              color: GlobalVariables.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.my_location_outlined,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Pick up",
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
                                                width: 4,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Drop off",
                                                    style:
                                                    TextStyle(color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text("SaT", style: TextStyle(
                                                          color: GlobalVariables
                                                              .primaryColor) ),
                                                    ),
                                                  ),

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
                                                  ),


                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ), ),
                                  Positioned(child: Stack(children: [
                                    Container(
                                      height: 60,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_back, color: Colors.grey,),
                                          SizedBox(width: 3,),
                                          Text("Adminstrative block"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 500 ,),
                                    Container(
                                      height: 70,
                                      width: double.infinity,
                                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        // child: CustomButton(onTap: () => , text: 'Apply',),
                                      ),
                                    ),
                                  ],)),

                                  Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: AnimatedSize(
                                        vsync:this,
                                        curve: Curves.bounceIn ,
                                        duration: new Duration(milliseconds: 160),
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
                                                    blurRadius: 16.0,
                                                    spreadRadius: 0.5,
                                                    offset: Offset(0.7, 0.7)
                                                )
                                              ]
                                          ),
                                          child: Column(
                                            children: [
                                              Text("SELECT YOUR SIDE?",style: TextStyle(
                                                  color: Colors.grey), ),
                                              SizedBox(height: 12,),
                                              Container(
                                                width: double.infinity ,
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0,),
                                                    child: Row(
                                                      children: [
                                                        Image.asset("", fit: BoxFit.fill,),
                                                        Column(children: [
                                                          Text("Dan jao", style: TextStyle(
                                                              color: GlobalVariables.primaryColor),),
                                                          SizedBox(height: 12,),
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
                                                        Image.asset("", fit: BoxFit.fill,),
                                                        Column(children: [
                                                          Text("Dan jao", style: TextStyle(
                                                              color: GlobalVariables.primaryColor),),
                                                          SizedBox(height: 12,),
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
                                                        Image.asset("", fit: BoxFit.fill,),
                                                        Column(children: [
                                                          Text("Dan jao", style: TextStyle(
                                                              color: GlobalVariables.primaryColor),),
                                                          SizedBox(height: 12,),
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
                                            ],
                                          ),
                                        ),
                                      ) ),
                                  Positioned(child: Column(children: [
                                    Container(
                                      width: double.infinity,
                                      height: 400,
                                      color: Colors.white,

                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(

                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 12,),
                                            Center(
                                              child: Container(
                                                height: 5,
                                                width: 26,
                                                color: GlobalVariables.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              height: 2,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  color: Colors.green,
                                                  child: Icon(Icons.phone_outlined),
                                                ),
                                                SizedBox(width: 15,),
                                                Container(
                                                  height: 60,
                                                  width: 90,
                                                  child:  Image.asset("/asset/im", fit: BoxFit.fill,),
                                                ),
                                                SizedBox(width: 15,),
                                                Container(
                                                  height: 6,
                                                  width: 6,
                                                  color: Colors.blue,
                                                  child: Icon(Icons.comment_outlined),)
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Column(
                                              children: [
                                                Text("Ademol tee 4", style: TextStyle(fontSize: 20),),
                                                SizedBox(height: 2,),
                                                Text("plate number: GH67857"),
                                              ],
                                            ),




                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.my_location_outlined,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Pick up",
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
                                                  width: 4,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Drop off",
                                                      style:
                                                      TextStyle(color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text("SaT", style: TextStyle(
                                                            color: GlobalVariables
                                                                .primaryColor) ),
                                                      ),
                                                    ),


                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              height: 2,
                                              width: double.infinity,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(height: 20,),
                                            Row(
                                              children: [
                                                Text("Price", style: TextStyle(
                                                    color:GlobalVariables.primaryColor),),
                                                Expanded(child: Text("250.00", style: TextStyle(
                                                    color:GlobalVariables.primaryColor) )),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            CustomTextfield(controller: _paymentController , hintext: "Payment method"),
                                            SizedBox(height: 12,),
                                            Center(
                                              child: GestureDetector(onTap: () => RegisterScreen.routeName,
                                                child: Text("Cancel Ride") ,),
                                            ),
                                            SizedBox(height: 4,),
                                            //  CustomButton(onTap: () => , text: "Book Ride")



                                          ],
                                        ),
                                      ),
                                    ),

                                  ],))



                                ],

                              );


                            });
                      },
                      icon: Icon(Icons.menu),),
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