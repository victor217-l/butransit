
import 'package:butransit/provider/provider.dart';
import 'package:butransit/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';


import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


import 'features/map/screen/ambulance.dart';
import 'features/map/screen/mapscreen.dart';
import 'features/startupage/screen/startupscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocationPermission permission = await Geolocator.requestPermission();
  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider())
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) =>  generateRoute(settings),
      home:  Startuppage(),
    );
  }
}

//how do i exctract the auth_token key from the json object above with  provider plugin using flutter

