import 'package:cloud_firestore/cloud_firestore.dart';

class UnitModel {
  final String id;
  final String name;
  final num price;
  final String status;
  final String venueId;
  final String type; // New field

  UnitModel({
    this.id = "",
    required this.name,
    required this.price,
    this.status = "",
    required this.venueId,
    required this.type, // New field
  });

  factory UnitModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var doc = snapshot.data() ?? {};

    return UnitModel(
      id: snapshot.id,
      name: doc['name'],
      price: doc['price'],
      status: doc['status'],
      venueId: doc['venueId'],
      type: doc['type'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'status': status,
      'venueId': venueId,
      'type': type,
    };
  }

  UnitModel copyWith({
    String? id,
    String? name,
    double? price,
    String? status,
    String? venueId,
    String? type, // New field
  }) {
    return UnitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      venueId: venueId ?? this.venueId,
      type: type ?? this.type, // New field
    );
  }
}
