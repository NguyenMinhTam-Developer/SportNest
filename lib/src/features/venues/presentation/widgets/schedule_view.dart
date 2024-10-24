import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/models/unit_model.dart';
import '../controllers/venue_detail_page_controller.dart';

class ScheduleView extends StatefulWidget {
  ScheduleView({super.key});

  final double headingColumnWidth = 56.w;
  final double slotHeight = 60.h * 1.25;
  final double slotWidth = 150.w;

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<VenueDetailPageController>(
      builder: (_) {
        return Scaffold(
          body: SafeArea(
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

                          return Column(
                            children: [
                              Divider(color: AppColor.neutralColor.shade50),
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
                                              height: widget.slotHeight,
                                              width: widget.headingColumnWidth,
                                            ),
                                            SizedBox(width: widget.headingColumnWidth, child: Divider(color: AppColor.neutralColor.shade50)),
                                            ...List.generate(times.length, (index) {
                                              var time = times[index];

                                              return Container(
                                                height: widget.slotHeight,
                                                width: widget.headingColumnWidth,
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
                                            height: widget.slotHeight * times.length,
                                            child: Builder(builder: (context) {
                                              Widget buildItem(UnitModel unit) {
                                                return SizedBox(
                                                  width: widget.slotWidth,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      SizedBox(
                                                        height: widget.slotHeight,
                                                        child: Center(
                                                          child: Text(unit.name),
                                                        ),
                                                      ),
                                                      Divider(color: AppColor.neutralColor.shade50),
                                                      Expanded(
                                                        child: FutureBuilder<List<BookingModel>>(
                                                          future: _.fetchBookingListFuture,
                                                          builder: (context, snapshot) {
                                                            List<BookingModel> bookings = snapshot.data?.where((booking) {
                                                                  if (booking.unitId != unit.id) return false;

                                                                  var startTime = booking.startTime!.toDate();

                                                                  if (startTime.day != _.selectedDate.day || startTime.month != _.selectedDate.month || startTime.year != _.selectedDate.year) return false;

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
                                                                      return SizedBox(width: widget.slotWidth, child: Divider(color: AppColor.neutralColor.shade50));
                                                                    },
                                                                    itemBuilder: (BuildContext context, int index) {
                                                                      return SizedBox(
                                                                        width: widget.slotWidth,
                                                                        height: widget.slotHeight,
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                ...List.generate(bookings.length, (index) {
                                                                  var booking = bookings[index];
                                                                  var startTime = booking.startTime!.toDate();
                                                                  var endTime = booking.endTime!.toDate();

                                                                  double convertMinutesToPixels(int minutes) {
                                                                    double ratio = widget.slotHeight / 60;

                                                                    int additionalHeight = minutes % 60;

                                                                    return (ratio * minutes + additionalHeight);
                                                                  }

                                                                  return Positioned(
                                                                    top: widget.slotHeight * startTime.hour,
                                                                    height: convertMinutesToPixels(endTime.difference(startTime).inMinutes),
                                                                    left: 0,
                                                                    right: 0,
                                                                    child: GestureDetector(
                                                                      onTap: () => Get.toNamed(
                                                                        Routes.bookingDetail.replaceFirst(':venueId', booking.venueId!).replaceFirst(':bookingId', booking.id!),
                                                                      ),
                                                                      child: Container(
                                                                        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                                                                        padding: EdgeInsets.all(8.w),
                                                                        decoration: BoxDecoration(
                                                                          color: booking.status!.backgroundColor,
                                                                          borderRadius: BorderRadius.circular(8.r),
                                                                          border: Border.all(color: booking.status!.foregroundColor, strokeAlign: BorderSide.strokeAlignInside),
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                          children: [
                                                                            Text(
                                                                              booking.customer!.name,
                                                                              style: AppTypography.bodyMedium.semiBold,
                                                                            ),
                                                                            Text(
                                                                              "From: ${DateFormat("hh:mm a").format(startTime)} - To: ${DateFormat("hh:mm a").format(endTime)}",
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
                                              }

                                              if (slots.length.isLowerThan(3)) {
                                                List<Widget> data = [];

                                                for (var slot in slots) {
                                                  data.add(Expanded(child: buildItem(slot)));
                                                  data.add(VerticalDivider(color: AppColor.neutralColor.shade50));
                                                }

                                                return Row(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: data,
                                                );
                                              } else {
                                                return ListView.separated(
                                                  itemCount: slots.length,
                                                  scrollDirection: Axis.horizontal,
                                                  physics: const ClampingScrollPhysics(),
                                                  separatorBuilder: (BuildContext context, int index) {
                                                    return VerticalDivider(color: AppColor.neutralColor.shade50);
                                                  },
                                                  itemBuilder: (BuildContext context, int index) {
                                                    var slot = slots[index];

                                                    return buildItem(slot);
                                                  },
                                                );
                                              }
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(color: AppColor.neutralColor.shade50),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _.onAddBooking,
            child: const Icon(Symbols.calendar_add_on_rounded),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
