import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/sources/firebase/firebase_storage_source.dart';
import '../../../../../generated/locales.g.dart';

import '../../../../controllers/application_controller.dart';
import '../../../../data/models/venue_model.dart';
import '../../../../controllers/authentication_controller.dart';
import '../../../../data/models/media_model.dart';

class CreateVenuePageController extends GetxController {
  bool isLoading = false;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final List<File> imageFiles = [];
  final _picker = ImagePicker();
  final _storageSource = FirebaseStorageSource();

  Future<void> onAddImagesPressed() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      imageFiles.addAll(images.map((image) => File(image.path)));
      update();
    }
  }

  void removeImage(int index) {
    imageFiles.removeAt(index);
    update();
  }

  Future<List<MediaModel>> _uploadImages(String venueId) async {
    List<MediaModel> mediaList = [];

    for (var i = 0; i < imageFiles.length; i++) {
      String path = 'venues/$venueId/image_$i.jpg';
      try {
        await _storageSource.storage.ref(path).putFile(imageFiles[i]);
        String url = await _storageSource.storage.ref(path).getDownloadURL();
        mediaList.add(MediaModel(index: i, url: url));
      } catch (e) {
        throw Exception('Failed to upload image: $e');
      }
    }

    return mediaList;
  }

  Future<void> onSubmitPressed() async {
    if (formKey.currentState!.saveAndValidate()) {
      String name = formKey.currentState!.fields['name']!.value as String;
      String address = formKey.currentState!.fields['address']!.value as String;
      DateTime openTime = formKey.currentState!.fields['openTime']!.value;
      DateTime closeTime = formKey.currentState!.fields['closeTime']!.value;
      String description = formKey.currentState!.fields['description']!.value as String;

      if (!openTime.isBefore(closeTime)) {
        Get.snackbar('Alert!', 'Open time must be earlier than the close time');
        return;
      }

      try {
        isLoading = true;
        update();

        // Create venue first to get the ID
        final venue = VenueModel(
          name: name,
          address: address,
          openTime: openTime,
          closeTime: closeTime,
          description: description,
          createdBy: AuthenticationController.instance.currentUserModel.value!.id,
        );

        // Upload venue to get the ID
        final createdVenue = await ApplicationController.instance.createVenue(venue);

        // Upload images
        if (imageFiles.isNotEmpty) {
          final mediaList = await _uploadImages(createdVenue.id);

          // Update venue with media list
          await ApplicationController.instance.updateVenue(
            createdVenue.copyWith(mediaList: mediaList),
          );
        }

        isLoading = false;
        update();

        Get.back(result: true, closeOverlays: true);

        Get.snackbar(
          LocaleKeys.success.tr,
          LocaleKeys.venue_created_successfully.tr,
        );
      } catch (e) {
        Get.snackbar(
          LocaleKeys.alert.tr,
          LocaleKeys.failed_to_create_venue.tr,
        );
      }
    } else {
      autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
    }
  }
}

class CreateVenuePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateVenuePageController>(() => CreateVenuePageController());
  }
}
