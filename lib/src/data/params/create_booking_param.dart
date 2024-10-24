import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/booking_status_enum.dart';

class CreateBookingParam {
  final String venueId;
  final String unitId;
  final String customerId;
  final Timestamp startTime;
  final Timestamp endTime;
  final String createdBy;

  CreateBookingParam({
    required this.venueId,
    required this.unitId,
    required this.customerId,
    required this.startTime,
    required this.endTime,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'venueId': venueId,
      'unitId': unitId,
      'customerId': customerId,
      'startTime': startTime,
      'endTime': endTime,
      'status': BookingStatusEnum.confirmed.toJson(),
      'createdBy': createdBy,
      'createdAt': Timestamp.now(),
    };
  }
}
