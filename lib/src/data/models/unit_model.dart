class UnitModel {
  final String id;
  final String name;
  final double price;
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

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      status: json['status'],
      venueId: json['venueId'],
      type: json['type'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'status': status,
      'venueId': venueId,
      'type': type, // New field
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
