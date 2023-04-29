import 'dart:convert';

class Driver {
  final int id;
  final String name;
  final int capacity;
  final String vehicleType;
  final int rating;
  final String plateNumber;
  final String phoneNumber;
  final String profileImage;
  final int ridePrice;
  final int rideTime;
  final int arrivalTime;

  Driver({
    required this.id,
    required this.name,
    required this.capacity,
    required this.vehicleType,
    required this.rating,
    required this.plateNumber,
    required this.phoneNumber,
    required this.profileImage,
    required this.ridePrice,
    required this.rideTime,
    required this.arrivalTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'driver_id': id,
      'driver_name': name,
      'capacity': capacity,
      'vehicle_type': vehicleType,
      'rating': rating,
      'driver_plate_no': plateNumber,
      'driver_phone_no': phoneNumber,
      'profile_image': profileImage,
      'ride_price': ridePrice,
      'ride_time': rideTime,
      'arrival_time': arrivalTime,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['driver_id'],
      name: map['driver_name'],
      capacity: map['capacity'],
      vehicleType: map['vehicle_type'],
      rating: map['rating'],
      plateNumber: map['driver_plate_no'],
      phoneNumber: map['driver_phone_no'],
      profileImage: map['profile_image'],
      ridePrice: map['ride_price'],
      rideTime: map['ride_time'],
      arrivalTime: map['arrival_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) =>
      Driver.fromMap(json.decode(source));
}
