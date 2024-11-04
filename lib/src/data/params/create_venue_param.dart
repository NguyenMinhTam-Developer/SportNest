import 'package:cloud_firestore/cloud_firestore.dart';

class CreateVenueParam {
  final String id;
  final String name;
  final String address;
  final DateTime openTime;
  final DateTime closeTime;
  final String description;

  CreateVenueParam({
    required this.id,
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'openTime': Timestamp.fromDate(openTime),
      'closeTime': Timestamp.fromDate(closeTime),
      'description': description,
    };
  }
}
