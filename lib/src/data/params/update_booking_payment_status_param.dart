import '../enums/payment_status_enum.dart';

class UpdateBookingPaymentStatusParam {
  final String id;
  final PaymentStatusEnum paymentStatus;

  UpdateBookingPaymentStatusParam({
    required this.id,
    required this.paymentStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paymentStatus': paymentStatus.toJson(),
    };
  }
}
