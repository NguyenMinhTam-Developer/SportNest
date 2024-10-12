import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/booking_page_controller.dart';

class BookingPage extends GetView<BookingPageController> {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Bookings View"),
    );
  }
}
