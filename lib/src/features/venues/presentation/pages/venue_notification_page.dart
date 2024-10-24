import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../data/models/booking_model.dart';
import '../../../../shared/extensions/hardcode.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../../../booking/presentation/pages/booking_list_page.dart';
import '../controllers/venue_detail_page_controller.dart';

class VeunueNotificationPage extends GetView<VenueDetailPageController> {
  const VeunueNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking Requests'.isHardcoded)),
      body: SafeArea(
        child: GetBuilder<VenueDetailPageController>(
          builder: (controller) {
            return FutureBuilder<List<BookingModel>>(
              future: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return ListIndicator(
                    icon: Symbols.error_rounded,
                    label: "Failed to load venue detail".isHardcoded,
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return ListIndicator(
                    icon: Symbols.today_rounded,
                    label: "You don't have any booking".isHardcoded,
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  clipBehavior: Clip.none,
                  itemCount: snapshot.requireData.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16.w);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var booking = snapshot.requireData[index];

                    return VenueBookingItemWidget(booking: booking);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
