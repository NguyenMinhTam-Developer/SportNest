import 'package:cloud_firestore/cloud_firestore.dart';

import 'venue_model.dart';
import 'unit_model.dart';

class BookingModel {
  final String id;
  final String userId;
  final String venueId;
  final String unitId;
  final DateTime startTime;
  final DateTime endTime;
  final String contactName;
  final String phoneNumber;
  final String status;

  final VenueModel? venue;
  final UnitModel? unit;

  BookingModel({
    required this.id,
    required this.userId,
    required this.venueId,
    required this.unitId,
    required this.startTime,
    required this.endTime,
    required this.contactName,
    required this.phoneNumber,
    required this.status,
    this.venue,
    this.unit,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      venueId: json['venueId'] as String,
      unitId: json['unitId'] as String,
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      contactName: json['contactName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'venueId': venueId,
      'unitId': unitId,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'contactName': contactName,
      'phoneNumber': phoneNumber,
      'status': status,
    };
  }

  BookingModel copyWith({
    String? id,
    String? userId,
    String? venueId,
    String? unitId,
    DateTime? startTime,
    DateTime? endTime,
    String? contactName,
    String? phoneNumber,
    String? status,
    VenueModel? venue,
    UnitModel? unit,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      venueId: venueId ?? this.venueId,
      unitId: unitId ?? this.unitId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      contactName: contactName ?? this.contactName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      venue: venue ?? this.venue,
      unit: unit ?? this.unit,
    );
  }
}
