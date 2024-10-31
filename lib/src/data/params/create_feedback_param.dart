class CreateFeedbackParam {
  final String title;
  final String content;
  final String userId;
  final List<String> imagePaths;
  final String? videoPath;

  CreateFeedbackParam({
    required this.title,
    required this.content,
    required this.userId,
    this.imagePaths = const [],
    this.videoPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'userId': userId,
      'imageUrls': [], // Will be updated after uploading images
      'videoUrl': null, // Will be updated after uploading video
      'createdAt': DateTime.now(),
    };
  }
}
