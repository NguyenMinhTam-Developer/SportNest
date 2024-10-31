import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageSource {
  final _storage = FirebaseStorage.instance;

  Future<List<String>> uploadFeedbackImages(
    String userId,
    String feedbackId,
    List<String> imagePaths,
  ) async {
    List<String> imageUrls = [];

    for (var i = 0; i < imagePaths.length; i++) {
      String path = 'feedbacks/$userId/$feedbackId/image_$i.jpg';
      File file = File(imagePaths[i]);

      try {
        await _storage.ref(path).putFile(file);
        String downloadUrl = await _storage.ref(path).getDownloadURL();
        imageUrls.add(downloadUrl);
      } catch (e) {
        throw Exception('Failed to upload image: $e');
      }
    }

    return imageUrls;
  }

  Future<String?> uploadFeedbackVideo(
    String userId,
    String feedbackId,
    String videoPath,
  ) async {
    if (videoPath.isEmpty) return null;

    String path = 'feedbacks/$userId/$feedbackId/video.mp4';
    File file = File(videoPath);

    try {
      await _storage.ref(path).putFile(file);
      return await _storage.ref(path).getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload video: $e');
    }
  }
}
