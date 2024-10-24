import '../enums/booking_status_enum.dart';

class UpdateBookingStatusParam {
  final String id;
  final BookingStatusEnum status;

  UpdateBookingStatusParam({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.toJson(),
    };
  }
}
