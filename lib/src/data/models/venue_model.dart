import 'unit_model.dart';
import 'media_model.dart';

class VenueModel {
  final String id;
  final String name;
  final String address;
  final DateTime openTime;
  final DateTime closeTime;
  final String description;
  final String createdBy;

  List<UnitModel> unitList = [];
  List<MediaModel> mediaList = [];

  VenueModel({
    this.id = "",
    required this.name,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.description,
    required this.createdBy,
    this.mediaList = const [],
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
      mediaList: (json['mediaList'] as List<dynamic>?)?.map((media) => MediaModel.fromJson(media)).toList() ?? [],
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
      'mediaList': mediaList.map((media) => media.toJson()).toList(),
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
    List<MediaModel>? mediaList,
  }) {
    return VenueModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      mediaList: mediaList ?? this.mediaList,
    );
  }
}
