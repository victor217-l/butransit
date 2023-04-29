import 'dart:convert';

class Ride {
  final int id;
  final int rideId;
  final String currentRideState;
  final String rideVehicle;
  final String currentLocation;
  final String destination;
  final DateTime dateTime;

  Ride({
    required this.id,
    required this.rideId,
    required this.currentRideState,
    required this.rideVehicle,
    required this.currentLocation,
    required this.destination,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ride_id': rideId,
      'current_ride_state': currentRideState,
      'ride_vehicle': rideVehicle,
      'current_location': currentLocation,
      'destination': destination,
      'date_time': dateTime.toIso8601String(),
    };
  }

  factory Ride.fromMap(Map<String, dynamic> map) {
    return Ride(
      id: map['id'],
      rideId: map['ride_id'],
      currentRideState: map['current_ride_state'],
      rideVehicle: map['ride_vehicle'],
      currentLocation: map['current_location'],
      destination: map['destination'],
      dateTime: DateTime.parse(map['date_time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ride.fromJson(String source) => Ride.fromMap(json.decode(source));
}
