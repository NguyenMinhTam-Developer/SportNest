import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService extends GetxController implements GetxService {
  static const String _storageKey = 'selected_locale';
  final _storage = GetStorage();

  // Default to English if no supported locale is found
  static const Locale defaultLocale = Locale('en', 'US');

  // List of supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('vi', 'VN'), // Vietnamese
    Locale('ko', 'KR'), // Korean
  ];

  Locale currentLocale = defaultLocale;

  static LanguageService instance = Get.find<LanguageService>();

  Future<LanguageService> init() async {
    // Check if there's a saved locale in storage first
    final String? savedLocale = _storage.read(_storageKey);

    if (savedLocale != null) {
      // If there's a saved locale, use it
      final parts = savedLocale.split('_');
      currentLocale = Locale(parts[0], parts[1]);
    } else {
      // Get device locale
      final deviceLocale = Get.deviceLocale;

      // Find the first matching supported locale based on language code
      final supportedLocale = supportedLocales.firstWhereOrNull(
        (locale) => locale.languageCode == deviceLocale?.languageCode,
      );

      // Use the matched locale or fall back to default
      currentLocale = supportedLocale ?? defaultLocale;

      // Save the initial locale
      await _storage.write(
        _storageKey,
        '${currentLocale.languageCode}_${currentLocale.countryCode}',
      );
    }

    // Update app locale
    Get.updateLocale(currentLocale);
    return this;
  }

  bool _isSupported(Locale? locale) {
    if (locale == null) return false;
    return supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  Future<void> changeLocale(String languageCode, String countryCode) async {
    final newLocale = Locale(languageCode, countryCode);

    // Verify if the new locale is supported
    if (!_isSupported(newLocale)) {
      return;
    }

    // Save to storage
    await _storage.write(_storageKey, '${languageCode}_$countryCode');

    // Update current locale
    currentLocale = newLocale;

    // Update app locale
    Get.updateLocale(newLocale);
  }
}
