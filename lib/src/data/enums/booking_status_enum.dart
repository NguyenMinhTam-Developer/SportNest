import 'dart:ui';

import '../../shared/extensions/hardcode.dart';

enum BookingStatusEnum {
  pending,
  confirmed,
  cancelled,
  unknown;

  static BookingStatusEnum fromString(String status) {
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
        return 'Pending'.isHardcoded;
      case BookingStatusEnum.confirmed:
        return 'Confirmed'.isHardcoded;
      case BookingStatusEnum.cancelled:
        return 'Cancelled'.isHardcoded;
      default:
        return 'Unknown'.isHardcoded;
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
}
