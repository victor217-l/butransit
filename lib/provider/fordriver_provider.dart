import 'package:flutter/foundation.dart';

import '../model/fordriver_model.dart';

class DriversProvider with ChangeNotifier {
  List<Driver> _drivers = [];

  List<Driver> get drivers => _drivers;

  void setDrivers(List<Driver> drivers) {
    _drivers = drivers;
    notifyListeners();
  }

}


