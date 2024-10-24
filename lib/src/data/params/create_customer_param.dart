import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCustomerParam {
  final String name;
  final String phoneNumber;
  final String email;
  final String address;
  final String createdBy;

  CreateCustomerParam({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'createdBy': createdBy,
      'updatedBy': createdBy,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    };
  }

  CreateCustomerParam copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? address,
    String? createdBy,
  }) {
    return CreateCustomerParam(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
