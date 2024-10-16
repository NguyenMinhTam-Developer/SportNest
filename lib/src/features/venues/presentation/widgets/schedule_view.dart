import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sport_nest_flutter/src/core/design/color.dart';
import 'package:sport_nest_flutter/src/core/design/typography.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/models/unit_model.dart';
import '../controllers/venue_detail_page_controller.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<VenueDetailPageController>(
      builder: (_) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: FormBuilderDateTimePicker(
                  name: "date",
                  initialValue: _.selectedDate,
                  textAlign: TextAlign.center,
                  inputType: InputType.date,
                  format: DateFormat("EEEE, MMMM d, yyyy"),
                  onChanged: (value) {
                    if (value != null) {
                      _.selectedDate = value;
                      _.fetchBookingList(_.venueId);
                    }
                  },
                ),
              ),
              Divider(color: AppColor.neutralColor.shade50),
              Expanded(
                child: FutureBuilder<List<UnitModel>>(
                    future: _.fetchUnitListFuture,
                    builder: (context, snapshot) {
                      return Builder(
                        builder: (context) {
                          List<TimeOfDay> times = [
                            const TimeOfDay(hour: 0, minute: 0),
                            const TimeOfDay(hour: 1, minute: 0),
                            const TimeOfDay(hour: 2, minute: 0),
                            const TimeOfDay(hour: 3, minute: 0),
                            const TimeOfDay(hour: 4, minute: 0),
                            const TimeOfDay(hour: 5, minute: 0),
                            const TimeOfDay(hour: 6, minute: 0),
                            const TimeOfDay(hour: 7, minute: 0),
                            const TimeOfDay(hour: 8, minute: 0),
                            const TimeOfDay(hour: 9, minute: 0),
                            const TimeOfDay(hour: 10, minute: 0),
                            const TimeOfDay(hour: 11, minute: 0),
                            const TimeOfDay(hour: 12, minute: 0),
                            const TimeOfDay(hour: 13, minute: 0),
                            const TimeOfDay(hour: 14, minute: 0),
                            const TimeOfDay(hour: 15, minute: 0),
                            const TimeOfDay(hour: 16, minute: 0),
                            const TimeOfDay(hour: 17, minute: 0),
                            const TimeOfDay(hour: 18, minute: 0),
                            const TimeOfDay(hour: 19, minute: 0),
                            const TimeOfDay(hour: 20, minute: 0),
                            const TimeOfDay(hour: 21, minute: 0),
                            const TimeOfDay(hour: 22, minute: 0),
                            const TimeOfDay(hour: 23, minute: 0),
                          ];

                          List<UnitModel> slots = snapshot.data ?? [];

                          double slotWidth = 150.w;

                          return Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 60.h,
                                              width: 56.w,
                                            ),
                                            SizedBox(width: 56.w, child: Divider(color: AppColor.neutralColor.shade50)),
                                            ...List.generate(times.length, (index) {
                                              var time = times[index];

                                              return Container(
                                                height: 60.h,
                                                width: 56.w,
                                                padding: EdgeInsets.only(right: 8.w),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Transform.translate(
                                                    offset: Offset(0, -AppTypography.bodySmall.medium.fontSize! / 1.5),
                                                    child: Text(
                                                      "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                                                      style: AppTypography.bodySmall.medium.copyWith(color: index != 0 ? AppColor.neutralColor.shade60 : Colors.transparent),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                        VerticalDivider(color: AppColor.neutralColor.shade50),
                                        Expanded(
                                          child: SizedBox(
                                            height: 60.h * times.length,
                                            child: ListView.separated(
                                              itemCount: slots.length,
                                              scrollDirection: Axis.horizontal,
                                              physics: const ClampingScrollPhysics(),
                                              separatorBuilder: (BuildContext context, int index) {
                                                return VerticalDivider(color: AppColor.neutralColor.shade50);
                                              },
                                              itemBuilder: (BuildContext context, int index) {
                                                var slot = slots[index];

                                                var item = SizedBox(
                                                  width: slotWidth,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      SizedBox(
                                                        height: 60.h,
                                                        child: Center(
                                                          child: Text(slot.name),
                                                        ),
                                                      ),
                                                      Divider(color: AppColor.neutralColor.shade50),
                                                      Expanded(
                                                        child: FutureBuilder<List<BookingModel>>(
                                                          future: _.fetchBookingListFuture,
                                                          builder: (context, snapshot) {
                                                            List<BookingModel> bookings = snapshot.data?.where((booking) {
                                                                  // if (booking.status != "Confirmed") return false;

                                                                  if (booking.unitId != slot.id) return false;

                                                                  if (booking.startTime.day != _.selectedDate.day || booking.startTime.month != _.selectedDate.month || booking.startTime.year != _.selectedDate.year) return false;

                                                                  return true;
                                                                }).toList() ??
                                                                [];

                                                            return Stack(
                                                              children: [
                                                                Positioned.fill(
                                                                  child: ListView.separated(
                                                                    itemCount: times.length,
                                                                    physics: const NeverScrollableScrollPhysics(),
                                                                    separatorBuilder: (BuildContext context, int index) {
                                                                      return SizedBox(width: slotWidth, child: Divider(color: AppColor.neutralColor.shade50));
                                                                    },
                                                                    itemBuilder: (BuildContext context, int index) {
                                                                      return SizedBox(
                                                                        width: slotWidth,
                                                                        height: 60.h,
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                ...List.generate(bookings.length, (index) {
                                                                  var booking = bookings[index];

                                                                  Color backgroundColor, foregroundColor;

                                                                  if (booking.status == "Confirmed") {
                                                                    backgroundColor = const Color(0xFFECFDF3);
                                                                    foregroundColor = const Color(0xFFABEFC6);
                                                                  } else if (booking.status == "Pending") {
                                                                    backgroundColor = const Color(0xFFF9F5FF);
                                                                    foregroundColor = const Color(0xFFE9D7FE);
                                                                  } else if (booking.status == "Cancelled") {
                                                                    backgroundColor = const Color(0xFFFEF3F2);
                                                                    foregroundColor = const Color(0xFFFECDCA);
                                                                  } else {
                                                                    backgroundColor = const Color(0xFFF8F8F8);
                                                                    foregroundColor = const Color(0xFFE0E0E0);
                                                                  }

                                                                  return Positioned(
                                                                    top: 60.h * booking.startTime.hour,
                                                                    height: booking.endTime.difference(booking.startTime).inMinutes.h,
                                                                    left: 0,
                                                                    right: 0,
                                                                    child: GestureDetector(
                                                                      onTap: () => Get.toNamed(
                                                                        Routes.bookingDetail.replaceFirst(':venueId', booking.venueId).replaceFirst(':bookingId', booking.id),
                                                                      ),
                                                                      child: Container(
                                                                        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                                                                        padding: EdgeInsets.all(8.w),
                                                                        decoration: BoxDecoration(
                                                                          color: backgroundColor,
                                                                          borderRadius: BorderRadius.circular(8.r),
                                                                          border: Border.all(color: foregroundColor, strokeAlign: BorderSide.strokeAlignInside),
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                          children: [
                                                                            Text(
                                                                              booking.contactName,
                                                                              style: AppTypography.bodyMedium.semiBold,
                                                                            ),
                                                                            Text(
                                                                              DateFormat("hh:mm a").format(booking.startTime),
                                                                              style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );

                                                return item;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
