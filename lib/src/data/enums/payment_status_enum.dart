import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../../../generated/locales.g.dart';

enum PaymentStatusEnum {
  pending,
  paid,
  failed,
  unknown;

  static PaymentStatusEnum? fromString(String? status) {
    switch (status) {
      case 'pending':
        return PaymentStatusEnum.pending;
      case 'paid':
        return PaymentStatusEnum.paid;
      case 'failed':
        return PaymentStatusEnum.failed;
      default:
        return PaymentStatusEnum.unknown;
    }
  }

  String toJson() {
    switch (this) {
      case PaymentStatusEnum.pending:
        return 'pending';
      case PaymentStatusEnum.paid:
        return 'paid';
      case PaymentStatusEnum.failed:
        return 'failed';
      default:
        return 'unknown';
    }
  }

  String toDisplayString() {
    switch (this) {
      case PaymentStatusEnum.pending:
        return LocaleKeys.pending.tr;
      case PaymentStatusEnum.paid:
        return LocaleKeys.paid.tr;
      case PaymentStatusEnum.failed:
        return LocaleKeys.failed.tr;
      default:
        return LocaleKeys.unknown.tr;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case PaymentStatusEnum.pending:
        return const Color(0xFFF9F5FF);
      case PaymentStatusEnum.paid:
        return const Color(0xFFECFDF3);
      case PaymentStatusEnum.failed:
        return const Color(0xFFFEF3F2);
      default:
        return const Color(0xFFF8F8F8);
    }
  }

  Color get foregroundColor {
    switch (this) {
      case PaymentStatusEnum.pending:
        return const Color(0xFFE9D7FE);
      case PaymentStatusEnum.paid:
        return const Color(0xFFABEFC6);
      case PaymentStatusEnum.failed:
        return const Color(0xFFFECDCA);
      default:
        return const Color(0xFFE0E0E0);
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentStatusEnum.pending:
        return Symbols.pending_rounded;
      case PaymentStatusEnum.paid:
        return Symbols.paid_rounded;
      case PaymentStatusEnum.failed:
        return Symbols.cancel_rounded;
      default:
        return Symbols.question_mark_rounded;
    }
  }
}
