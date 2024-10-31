import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;

  String get firstName => username.split(' ').first;
  String get lastName => username.split(' ').last;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber = "",
  });

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      id: snapshot.id,
      username: snapshot.data()?['username'] ?? "",
      email: snapshot.data()?['email'] ?? "",
      phoneNumber: snapshot.data()?['phoneNumber'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
