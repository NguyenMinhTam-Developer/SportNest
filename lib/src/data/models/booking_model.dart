import 'package:cloud_firestore/cloud_firestore.dart';
import '../enums/booking_status_enum.dart';
import 'venue_model.dart';

import 'customer_model.dart';
import 'unit_model.dart';

class BookingModel {
  final String? id;
  final String? venueId;
  final String? unitId;
  final String? customerId;
  final Timestamp? startTime;
  final Timestamp? endTime;
  final BookingStatusEnum? status;

  final String? createdBy;
  final String? updatedBy;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  VenueModel? venue;
  UnitModel? unit;
  CustomerModel? customer;

  BookingModel({
    required this.id,
    required this.venueId,
    required this.unitId,
    required this.startTime,
    required this.endTime,
    required this.customerId,
    required this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  factory BookingModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? {};

    try {
      return BookingModel(
        id: document.id,
        venueId: data['venueId'],
        unitId: data['unitId'],
        startTime: data['startTime'],
        endTime: data['endTime'],
        customerId: data['customerId'],
        status: BookingStatusEnum.fromString(data['status']),
        createdBy: data['createdBy'],
        updatedBy: data['updatedBy'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );
    } catch (e) {
      throw Exception('Failed to parse BookingModel: $e');
    }
  }
}
