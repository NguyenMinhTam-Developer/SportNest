import 'package:get/get.dart';

import '../../../core/routes/pages.dart';
import '../../../services/authentication_service.dart';

class SplashPageController extends GetxController {
  final AuthService _authService = AuthService.instance;

  final Duration _splashDuration = const Duration(seconds: 3);

  @override
  void onInit() {
    Future.delayed(_splashDuration, () {
      if (_authService.isSignedIn) {
        Get.offNamed(Routes.home);
      } else {
        Get.offNamed(Routes.signIn);
      }
    });

    super.onInit();
  }
}

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashPageController>(() => SplashPageController());
  }
}
