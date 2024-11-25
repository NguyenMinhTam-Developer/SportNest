import 'package:get/get.dart';

import '../../../controllers/authentication_controller.dart';
import '../../../core/routes/pages.dart';

class SplashPageController extends GetxController {
  final AuthenticationController _authController = AuthenticationController.instance;
  final Duration _splashDuration = const Duration(seconds: 3);

  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(_splashDuration);

    final user = await _authController.checkAuthState();

    if (user != null) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.signIn);
    }
  }
}

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashPageController>(() => SplashPageController());
  }
}
