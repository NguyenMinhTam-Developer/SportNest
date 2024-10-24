import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateCustomerParam {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String address;
  final String updatedBy;

  UpdateCustomerParam({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.updatedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'updatedBy': updatedBy,
      'updatedAt': Timestamp.now(),
    };
  }
}
