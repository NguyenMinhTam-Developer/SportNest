import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_nest_flutter/src/data/params/create_feedback_param.dart';
import 'package:sport_nest_flutter/src/data/sources/firebase/firebase_firestore_source.dart';
import 'package:sport_nest_flutter/src/data/sources/firebase/firebase_storage_source.dart';
import 'package:sport_nest_flutter/src/services/authentication_service.dart';

import '../../../generated/locales.g.dart';

class FeedbackPageController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final isLoading = false.obs;
  final selectedImages = <String>[].obs;
  final selectedVideo = ''.obs;

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final images = await picker.pickMultiImage();

    selectedImages.value = images.map((e) => e.path).toList();
  }

  Future<void> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      selectedVideo.value = video.path;
    }
  }

  Future<void> submitFeedback() async {
    if (!formKey.currentState!.saveAndValidate()) return;

    try {
      isLoading.value = true;
      final values = formKey.currentState!.value;

      // Create feedback document first
      final param = CreateFeedbackParam(
        title: values['title'],
        content: values['content'],
        userId: AuthService.instance.currentUserModel!.id,
        imagePaths: selectedImages,
        videoPath: selectedVideo.value,
      );

      // Create initial feedback document
      final feedback = await FirebaseFirestoreSource().createFeedback(param, [], null);

      // Upload media files
      final imageUrls = await FirebaseStorageSource().uploadFeedbackImages(
        feedback.userId,
        feedback.id!,
        selectedImages,
      );

      String? videoUrl;
      if (selectedVideo.value.isNotEmpty) {
        videoUrl = await FirebaseStorageSource().uploadFeedbackVideo(
          feedback.userId,
          feedback.id!,
          selectedVideo.value,
        );
      }

      // Update feedback with media URLs
      await FirebaseFirestoreSource().createFeedback(param, imageUrls, videoUrl);

      Get.back();
      Get.snackbar(
        LocaleKeys.success.tr,
        LocaleKeys.feedbackSentSuccessfully.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        LocaleKeys.error.tr,
        LocaleKeys.failedToSendFeedback.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
