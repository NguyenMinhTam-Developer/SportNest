import 'package:get/get.dart';

import '../features/schedule/presentation/controllers/schedule_page_controller.dart';

class DataAsyncService extends GetxService {
  Future<DataAsyncService> init() async {
    return this;
  }

  Future<void> refreshSchedulePage() async {
    SchedulePageController.instance?.fetchVenueList();
    SchedulePageController.instance?.fetchBookingList();
  }

  static DataAsyncService? get instance => Get.find<DataAsyncService>();
}
