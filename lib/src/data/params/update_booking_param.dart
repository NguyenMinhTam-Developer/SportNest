import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateBookingParam {
  final String id;
  final String venueId;
  final String unitId;
  final String customerId;
  final Timestamp startTime;
  final Timestamp endTime;
  final String updatedBy;
  final Timestamp updatedAt;

  UpdateBookingParam({
    required this.id,
    required this.venueId,
    required this.unitId,
    required this.customerId,
    required this.startTime,
    required this.endTime,
    required this.updatedBy,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'venueId': venueId,
      'unitId': unitId,
      'customerId': customerId,
      'startTime': startTime,
      'endTime': endTime,
      'updatedBy': updatedBy,
      'updatedAt': updatedAt,
    };
  }
}
