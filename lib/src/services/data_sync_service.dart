import 'package:get/get.dart';

import '../features/venues/presentation/controllers/venue_list_page_controller.dart';

class DataSyncService extends GetxService {
  static DataSyncService get instance => Get.find<DataSyncService>();

  Future<DataSyncService> init() async {
    return this;
  }

  Future<void> refreshVenueList() async => await VenueListPageController.instance.fetchVenues();
}
