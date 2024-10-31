import 'package:cloud_firestore/cloud_firestore.dart';
import '../../library/colors.dart';
import '../enums/booking_status_enum.dart';
import '../enums/payment_status_enum.dart';
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
  final BookingStatusEnum status;
  final PaymentStatusEnum paymentStatus;
  final num? price;

  final String? createdBy;
  final String? updatedBy;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  VenueModel? venue;
  UnitModel? unit;
  CustomerModel? customer;

  int get numericId {
    if (id == null) return 0;

    // Convert string to consistent numeric value within 32-bit integer range
    int numeric = 0;
    for (int i = 0; i < id!.length; i++) {
      numeric = ((numeric * 31) % 0x7FFFFFFF) + (id!.codeUnitAt(i) % 0x7FFFFFFF);
      numeric = numeric % 0x7FFFFFFF; // Keep within 31-bit positive range
    }
    return numeric;
  }

  BookingModel({
    required this.id,
    required this.venueId,
    required this.unitId,
    required this.startTime,
    required this.endTime,
    required this.customerId,
    required this.status,
    required this.paymentStatus,
    required this.price,
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
        status: BookingStatusEnum.fromString(data['status']) ?? BookingStatusEnum.unknown,
        paymentStatus: PaymentStatusEnum.fromString(data['paymentStatus']) ?? PaymentStatusEnum.unknown,
        price: data['price'],
        createdBy: data['createdBy'],
        updatedBy: data['updatedBy'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
      );
    } catch (e) {
      throw Exception('Failed to parse BookingModel: $e');
    }
  }

  BasicColor get color {
    List<BasicColor> colorList = [
      SecondaryColors().grayBlue,
      SecondaryColors().grayCool,
      SecondaryColors().grayModern,
      SecondaryColors().grayNeutral,
      SecondaryColors().grayIron,
      SecondaryColors().grayTrue,
      SecondaryColors().grayWarm,
      SecondaryColors().moss,
      SecondaryColors().greenLight,
      SecondaryColors().green,
      SecondaryColors().teal,
      SecondaryColors().cyan,
      SecondaryColors().blueLight,
      SecondaryColors().blue,
      SecondaryColors().blueDark,
      SecondaryColors().indigo,
      SecondaryColors().violet,
      SecondaryColors().purple,
      SecondaryColors().fuchsia,
      SecondaryColors().pink,
      SecondaryColors().rose,
      SecondaryColors().orangeDark,
      SecondaryColors().orange,
      SecondaryColors().yellow,
    ];

    // Use the new numericId instead of hashCode
    int colorIndex = numericId % colorList.length;
    return colorList[colorIndex];
  }
}
