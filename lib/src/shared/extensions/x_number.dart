import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../services/language_service.dart';

extension NumberFormatX on num {
  /// Formats number to currency format
  /// Example: 1000000 -> $1.000.000
  String toCurrency({String? symbol, bool withSymbol = true, int decimalDigits = 0}) {
    String defaultSymbol = symbol ?? '';

    final languageService = Get.find<LanguageService>();
    switch (languageService.currentLocale.languageCode) {
      case 'en':
        defaultSymbol = '\$';
        break;
      case 'vi':
        defaultSymbol = '₫';
        break;
      case 'ko':
        defaultSymbol = '₩';
        break;
      default:
        break;
    }

    final formatter = NumberFormat.currency(
      locale: languageService.currentLocale.languageCode,
      symbol: withSymbol ? symbol ?? defaultSymbol : '',
      decimalDigits: decimalDigits,
    );
    return formatter.format(this);
  }

  /// Formats number with thousand separator
  /// Example: 1000000 -> 1.000.000
  String toThousandSeparator() {
    final languageService = Get.find<LanguageService>();
    final formatter = NumberFormat('#,###', languageService.currentLocale.languageCode);
    return formatter.format(this);
  }

  /// Formats number to compact format
  /// Example: 1000000 -> 1Tr
  String toCompact() {
    final languageService = Get.find<LanguageService>();
    final formatter = NumberFormat.compact(locale: languageService.currentLocale.languageCode);
    return formatter.format(this);
  }

  /// Formats number to percentage
  /// Example: 0.75 -> 75%
  String toPercentage({int decimalDigits = 0}) {
    final languageService = Get.find<LanguageService>();
    final formatter = NumberFormat.percentPattern(languageService.currentLocale.languageCode);
    formatter.maximumFractionDigits = decimalDigits;
    return formatter.format(this);
  }

  /// Formats decimal number
  /// Example: 1000.123456 -> 1.000,12
  String toDecimal({int decimalDigits = 2}) {
    final formatter = NumberFormat.decimalPattern('vi_VN')..maximumFractionDigits = decimalDigits;
    return formatter.format(this);
  }
}
