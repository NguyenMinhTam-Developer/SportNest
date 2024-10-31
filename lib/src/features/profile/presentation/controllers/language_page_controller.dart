import 'package:get/get.dart';
import '../../../../services/language_service.dart';

class LanguagePageController extends GetxController {
  final _languageService = Get.find<LanguageService>();

  final languages = [
    {'name': 'English', 'code': 'en', 'country': 'US'},
    {'name': 'Tiếng Việt', 'code': 'vi', 'country': 'VN'},
    {'name': '한국어', 'code': 'ko', 'country': 'KR'},
  ];

  String get currentLanguageCode => _languageService.currentLocale.languageCode;

  void changeLanguage(String languageCode, String countryCode) {
    _languageService.changeLocale(languageCode, countryCode);
  }
}

class LanguagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguagePageController());
  }
}
