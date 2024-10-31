import 'package:get/get.dart';

import '../../../../core/routes/pages.dart';
import '../../../../services/data_async_service.dart';

class VenueListPageController extends GetxController {
  final DataAsyncService dataAsyncService = DataAsyncService.instance;

  Future<void> onAddVenuePressed() async {
    var result = await Get.toNamed(Routes.createVenue);

    if (result == true) {
      dataAsyncService.fetchVenueList();
    }
  }

  Future<void> onVenuePressed(String id) async {
    var result = await Get.toNamed(
      Routes.venueDetail.replaceFirst(":venueId", id),
      arguments: dataAsyncService.venueList.firstWhere((venue) => venue.id == id),
    );

    if (result == true) {
      dataAsyncService.fetchVenueList();
    }
  }

  Future<void> onRefresh() async {
    await dataAsyncService.fetchVenueList();
  }

  static VenueListPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(VenueListPageController());
    }
  }
}

class VenueListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueListPageController>(() => VenueListPageController());
  }
}
