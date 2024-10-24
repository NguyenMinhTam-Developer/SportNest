import 'package:cloud_firestore/cloud_firestore.dart';
import '../../library/colors.dart';
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

    // Generate a hash code from the customer ID
    int hash = id.hashCode;

    int colorIndex = hash % colorList.length;

    // Return the color from the list
    return colorList[colorIndex];
  }
}
