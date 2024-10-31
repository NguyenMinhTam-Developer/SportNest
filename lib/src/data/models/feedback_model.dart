import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String? id;
  final String title;
  final String content;
  final String userId;
  final List<String> imageUrls;
  final String? videoUrl;
  final DateTime createdAt;

  FeedbackModel({
    this.id,
    required this.title,
    required this.content,
    required this.userId,
    this.imageUrls = const [],
    this.videoUrl,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'userId': userId,
      'imageUrls': imageUrls,
      'videoUrl': videoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory FeedbackModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return FeedbackModel(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      userId: data['userId'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      videoUrl: data['videoUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
