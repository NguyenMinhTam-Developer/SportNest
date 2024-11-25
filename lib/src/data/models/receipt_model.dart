import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'booking_model.dart';
import '../../../generated/locales.g.dart';
import 'package:get/get.dart';

import '../../library/colors.dart';

enum ReceiptStatus {
  pending,
  paid,
  cancelled;

  static String label(ReceiptStatus? status) {
    switch (status) {
      case ReceiptStatus.pending:
        return LocaleKeys.enum_receipt_status_pending.tr;
      case ReceiptStatus.paid:
        return LocaleKeys.enum_receipt_status_paid.tr;
      case ReceiptStatus.cancelled:
        return LocaleKeys.enum_receipt_status_cancelled.tr;
      default:
        return LocaleKeys.enum_receipt_status_pending.tr;
    }
  }

  static Color backgroundColor(ReceiptStatus? status) {
    switch (status) {
      case ReceiptStatus.pending:
        return UntitledUiColors.primary.success.shade50;
      case ReceiptStatus.paid:
        return UntitledUiColors.primary.warning.shade50;
      case ReceiptStatus.cancelled:
        return UntitledUiColors.primary.error.shade50;
      default:
        return UntitledUiColors.primary.success.shade50;
    }
  }

  static Color borderColor(ReceiptStatus? status) {
    switch (status) {
      case ReceiptStatus.pending:
        return UntitledUiColors.primary.success.shade200;
      case ReceiptStatus.paid:
        return UntitledUiColors.primary.warning.shade200;
      case ReceiptStatus.cancelled:
        return UntitledUiColors.primary.error.shade200;
      default:
        return UntitledUiColors.primary.success.shade200;
    }
  }

  static Color foregroundColor(ReceiptStatus? status) {
    switch (status) {
      case ReceiptStatus.pending:
        return UntitledUiColors.primary.success.shade700;
      case ReceiptStatus.paid:
        return UntitledUiColors.primary.warning.shade700;
      case ReceiptStatus.cancelled:
        return UntitledUiColors.primary.error.shade700;
      default:
        return UntitledUiColors.primary.success.shade700;
    }
  }

  String get toJson {
    switch (this) {
      case ReceiptStatus.pending:
        return 'pending';
      case ReceiptStatus.paid:
        return 'paid';
      case ReceiptStatus.cancelled:
        return 'cancelled';
      default:
        return 'pending';
    }
  }

  static ReceiptStatus fromJson(String? status) {
    switch (status) {
      case 'pending':
        return ReceiptStatus.pending;
      case 'paid':
        return ReceiptStatus.paid;
      case 'cancelled':
        return ReceiptStatus.cancelled;
      default:
        return ReceiptStatus.pending;
    }
  }
}

enum PaymentMethod {
  cash,
  creditCard,
  bankTransfer;

  String get label {
    switch (this) {
      case PaymentMethod.cash:
        return LocaleKeys.enum_payment_method_cash.tr;
      case PaymentMethod.creditCard:
        return LocaleKeys.enum_payment_method_credit_card.tr;
      case PaymentMethod.bankTransfer:
        return LocaleKeys.enum_payment_method_bank_transfer.tr;
      default:
        return LocaleKeys.enum_payment_method_cash.tr;
    }
  }

  String get toJson {
    switch (this) {
      case PaymentMethod.cash:
        return 'cash';
      case PaymentMethod.creditCard:
        return 'creditCard';
      case PaymentMethod.bankTransfer:
        return 'bankTransfer';
      default:
        return 'cash';
    }
  }

  static PaymentMethod fromJson(String? method) {
    switch (method) {
      case 'cash':
        return PaymentMethod.cash;
      case 'creditCard':
        return PaymentMethod.creditCard;
      case 'bankTransfer':
        return PaymentMethod.bankTransfer;
      default:
        return PaymentMethod.cash;
    }
  }
}

class ReceiptModel {
  final String id;
  final String bookingId;
  final String? customerId;
  final String venueId;
  final String receiptNumber;
  final Timestamp issueDate;
  final Timestamp dueDate;
  final num subtotal;
  final num taxRate;
  final num taxAmount;
  final num totalAmount;
  final ReceiptStatus status;
  final PaymentMethod paymentMethod;
  final String? paymentReference;
  final List<ReceiptItemModel> items;
  final String notes;

  final String createdBy;
  final String? updatedBy;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  BookingModel? booking;

  ReceiptModel({
    required this.id,
    required this.bookingId,
    required this.customerId,
    required this.venueId,
    required this.receiptNumber,
    required this.issueDate,
    required this.dueDate,
    required this.subtotal,
    required this.taxRate,
    required this.taxAmount,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    this.paymentReference,
    required this.items,
    this.notes = '',
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    this.updatedAt,
  }) {
    // assert(totalAmount == subtotal + taxAmount, 'Total amount must equal subtotal plus tax');
    // assert(taxAmount == subtotal * taxRate, 'Tax amount must equal subtotal times tax rate');
    assert(ReceiptStatus.values.contains(status), 'Invalid status');
    assert(PaymentMethod.values.contains(paymentMethod), 'Invalid payment method');
  }

  factory ReceiptModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};

    return ReceiptModel(
      id: snapshot.id,
      bookingId: data['bookingId'],
      customerId: data['customerId'],
      venueId: data['venueId'],
      receiptNumber: data['receiptNumber'],
      issueDate: data['issueDate'],
      dueDate: data['dueDate'],
      subtotal: data['subtotal'],
      taxRate: data['taxRate'],
      taxAmount: data['taxAmount'],
      totalAmount: data['totalAmount'],
      status: ReceiptStatus.fromJson(data['status']),
      paymentMethod: PaymentMethod.fromJson(data['paymentMethod']),
      paymentReference: data['paymentReference'],
      items: (data['items'] as List<dynamic>).map((item) => ReceiptItemModel.fromJson(item)).toList(),
      notes: data['notes'] ?? '',
      createdBy: data['createdBy'],
      updatedBy: data['updatedBy'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'customerId': customerId,
      'venueId': venueId,
      'receiptNumber': receiptNumber,
      'issueDate': issueDate,
      'dueDate': dueDate,
      'subtotal': subtotal,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
      'status': status.toJson,
      'paymentMethod': paymentMethod.toJson,
      'paymentReference': paymentReference,
      'items': items.map((item) => item.toJson()).toList(),
      'notes': notes,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  bool get isPaid => status == ReceiptStatus.paid;
  Duration get daysOverdue => DateTime.now().difference(dueDate.toDate());
}

class ReceiptItemModel {
  final String description;
  final num quantity;
  final num unitPrice;
  final num amount;
  final String? unitId;
  final String? unitType;

  ReceiptItemModel({
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.amount,
    this.unitId,
    this.unitType,
  });

  factory ReceiptItemModel.fromJson(Map<String, dynamic> json) {
    return ReceiptItemModel(
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      amount: json['amount'],
      unitId: json['unitId'],
      unitType: json['unitType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'amount': amount,
      'unitId': unitId,
      'unitType': unitType,
    };
  }
}
