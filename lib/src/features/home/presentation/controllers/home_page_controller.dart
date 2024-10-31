import 'package:get/get.dart';

import '../../../../services/data_async_service.dart';

class HomePageController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    DataAsyncService.instance.fetchVenueList();
  }
}

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}
