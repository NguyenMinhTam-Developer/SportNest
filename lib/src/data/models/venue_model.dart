import 'unit_model.dart';

class VenueModel {
  final String id;
  final String name;
  final String address;
  final DateTime openTime;
  final DateTime closeTime;
  final String description;
  final String createdBy;

  List<UnitModel> unitList = [];

  VenueModel({
    this.id = "",
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.description,
    required this.createdBy,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      openTime: DateTime.parse(json['openTime']),
      closeTime: DateTime.parse(json['closeTime']),
      description: json['description'],
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'openTime': openTime.toIso8601String(),
      'closeTime': closeTime.toIso8601String(),
      'description': description,
      'createdBy': createdBy,
    };
  }

  VenueModel copyWith({
    String? id,
    String? name,
    String? address,
    DateTime? openTime,
    DateTime? closeTime,
    String? description,
    String? createdBy,
  }) {
    return VenueModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
