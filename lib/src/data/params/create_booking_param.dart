import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/booking_status_enum.dart';
import '../enums/payment_status_enum.dart';

class CreateBookingParam {
  final String venueId;
  final String unitId;
  final String customerId;
  final Timestamp startTime;
  final Timestamp endTime;
  final num price;
  final String createdBy;

  CreateBookingParam({
    required this.venueId,
    required this.unitId,
    required this.customerId,
    required this.startTime,
    required this.endTime,
    required this.price,
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
      'paymentStatus': PaymentStatusEnum.pending.toJson(),
      'price': price,
      'createdBy': createdBy,
      'createdAt': Timestamp.now(),
    };
  }
}
