import 'package:get/get.dart';

import '../../../core/routes/pages.dart';
import '../../../services/authentication_service.dart';

class SplashPageController extends GetxController {
  final AuthService _authService = AuthService.instance;
  final Duration _splashDuration = const Duration(seconds: 3);

  @override
  void onInit() {
    super.onInit();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    // Wait for minimum splash duration
    await Future.delayed(_splashDuration);

    // Wait a bit more if auth state is not determined yet
    int attempts = 0;
    while (attempts < 3) {
      if (_authService.currentUserModel != null) {
        Get.offNamed(Routes.home);
        return;
      } else if (_authService.currentUserModel == null) {
        Get.offNamed(Routes.signIn);
        return;
      }

      // Wait and try again
      await Future.delayed(const Duration(milliseconds: 500));
      attempts++;
    }

    // Default to sign in if we couldn't determine state
    Get.offNamed(Routes.signIn);
  }
}

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashPageController>(() => SplashPageController());
  }
}
