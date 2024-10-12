import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel {
  final String id;
  final String venueId;
  final String unitId;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;

  ScheduleModel({
    required this.id,
    required this.venueId,
    required this.unitId,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as String,
      venueId: json['venueId'] as String,
      unitId: json['unitId'] as String,
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      isAvailable: json['isAvailable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'unitId': unitId,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'isAvailable': isAvailable,
    };
  }

  ScheduleModel copyWith({
    String? id,
    String? venueId,
    String? unitId,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAvailable,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      unitId: unitId ?? this.unitId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
