import 'package:cloud_firestore/cloud_firestore.dart';

import '../../library/colors.dart';

class CustomerModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String address;
  final String createdBy;
  final String updatedBy;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? {};

    return CustomerModel(
      id: document.id,
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      email: data['email'] ?? "",
      address: data['address'] ?? "",
      createdBy: data['createdBy'],
      updatedBy: data['updatedBy'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }
}
