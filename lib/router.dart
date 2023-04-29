import 'package:butransit/features/auth/screen/login.dart';
import 'package:butransit/features/auth/screen/phoneverifi.dart';
import 'package:butransit/features/auth/screen/registerscreen.dart';
import 'package:butransit/features/auth/screen/healthscreen.dart';
import 'package:butransit/features/driver/screen/vehiclereport.dart';
import 'package:butransit/features/map/screen/ambulance.dart';
import 'package:butransit/features/map/screen/ambulanceforwithness.dart';
import 'package:butransit/features/map/screen/mapscreen.dart';
import 'package:butransit/features/map/screen/seelistofstudentride.dart';
import 'package:butransit/model/fordriver_model.dart';
import 'package:flutter/material.dart';

import 'features/driver/screen/loginfordeiver.dart';
import 'features/driver/screen/registerscreenfordriver.dart';
import 'features/driver/screen/seerides.dart';
import 'features/map/screen/seedriverpage.dart';
import 'main.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RegisterScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const RegisterScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());
    case Phoneverification.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Phoneverification());
    case LoginDriverScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,  builder: (_) => const LoginDriverScreen()
      );
    case HealthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,  builder: (_) => const HealthScreen()
      );
    case RegisterDriverScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,  builder: (_) => const RegisterDriverScreen()
      );
    case VehicleReport.routeName:
      return MaterialPageRoute(
          settings: routeSettings,  builder: (_) => const VehicleReport()
      );
    case MapScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  MapScreen());
    case AmbulanceDetail.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>  AmbulanceDetail());
    case AmbulanceDetailWitness.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>  AmbulanceDetailWitness());
    case DriveDetail.routeName:
      var driver = routeSettings.arguments as Driver;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>  DriveDetail(driver: driver,));

    case DriverRide.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>  DriverRide());
    case StudentListRide.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>  StudentListRide());


    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text("no pag"),
                ),
              ));
  }
}
