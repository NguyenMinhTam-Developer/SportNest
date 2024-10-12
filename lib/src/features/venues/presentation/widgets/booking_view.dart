import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/routes/pages.dart';
import '../../../booking/presentation/controllers/booking_list_page_controller.dart';
import '../../../booking/presentation/pages/booking_list_page.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key, required this.venueId});

  final String venueId;

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: GetBuilder<BookingListPageController>(
        init: BookingListPageController(),
        builder: (_) {
          return BookingListWidget(future: _.fetchBookingsFuture);
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "booking_fab",
        onPressed: () => Get.toNamed(
          Routes.bookingCreate,
          parameters: {"venueId": widget.venueId},
        ),
        child: const Icon(Symbols.calendar_add_on_rounded),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
