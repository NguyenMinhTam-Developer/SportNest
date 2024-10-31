import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../generated/locales.g.dart';

enum BookingStatusEnum {
  pending,
  confirmed,
  cancelled,
  unknown;

  static BookingStatusEnum? fromString(String? status) {
    switch (status) {
      case 'pending':
        return BookingStatusEnum.pending;
      case 'confirmed':
        return BookingStatusEnum.confirmed;
      case 'cancelled':
        return BookingStatusEnum.cancelled;
      default:
        return BookingStatusEnum.unknown;
    }
  }

  String toJson() {
    switch (this) {
      case BookingStatusEnum.pending:
        return 'pending';
      case BookingStatusEnum.confirmed:
        return 'confirmed';
      case BookingStatusEnum.cancelled:
        return 'cancelled';
      default:
        return 'unknown';
    }
  }

  String toDisplayString() {
    switch (this) {
      case BookingStatusEnum.pending:
        return LocaleKeys.pending.tr;
      case BookingStatusEnum.confirmed:
        return LocaleKeys.confirmed.tr;
      case BookingStatusEnum.cancelled:
        return LocaleKeys.cancelled.tr;
      default:
        return LocaleKeys.unknown.tr;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case BookingStatusEnum.confirmed:
        return const Color(0xFFECFDF3);
      case BookingStatusEnum.pending:
        return const Color(0xFFF9F5FF);
      case BookingStatusEnum.cancelled:
        return const Color(0xFFFEF3F2);
      default:
        return const Color(0xFFF8F8F8);
    }
  }

  Color get foregroundColor {
    switch (this) {
      case BookingStatusEnum.confirmed:
        return const Color(0xFFABEFC6);
      case BookingStatusEnum.pending:
        return const Color(0xFFE9D7FE);
      case BookingStatusEnum.cancelled:
        return const Color(0xFFFECDCA);
      default:
        return const Color(0xFFE0E0E0);
    }
  }

  IconData get icon {
    switch (this) {
      case BookingStatusEnum.confirmed:
        return Symbols.event_available_rounded;
      case BookingStatusEnum.pending:
        return Symbols.pending_rounded;
      case BookingStatusEnum.cancelled:
        return Symbols.cancel_rounded;
      default:
        return Symbols.event_busy_rounded;
    }
  }
}
