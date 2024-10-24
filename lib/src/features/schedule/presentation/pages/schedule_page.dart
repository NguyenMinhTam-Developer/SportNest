import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sport_nest_flutter/src/core/design/color.dart';
import 'package:sport_nest_flutter/src/core/design/typography.dart';
import '../../../../core/routes/pages.dart';
import '../../../../data/enums/view_mode_enum.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/models/unit_model.dart';
import '../controllers/schedule_page_controller.dart';

class SchedulePage extends GetView<SchedulePageController> {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchedulePageController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(controller.selectedVenue?.name ?? "Select Venue"),
              const SizedBox(width: 16),
              const Icon(Symbols.keyboard_arrow_down_rounded),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Symbols.search_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Symbols.calendar_add_on_rounded),
              onPressed: () {},
            ),
            PopupMenuButton<ViewMode>(
              icon: Icon(controller.viewModeIcon),
              onSelected: controller.setViewMode,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<ViewMode>>[
                const PopupMenuItem<ViewMode>(
                  value: ViewMode.day,
                  child: Text('Day View'),
                ),
                const PopupMenuItem<ViewMode>(
                  value: ViewMode.week,
                  child: Text('Week View'),
                ),
                const PopupMenuItem<ViewMode>(
                  value: ViewMode.month,
                  child: Text('Month View'),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.w),
            Container(
              height: 40.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD5D7DA), width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: controller.onPreviousPressed,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: const BoxDecoration(
                        border: Border(right: BorderSide(color: Color(0xFFD5D7DA), width: 1)),
                      ),
                      child: const Icon(Symbols.keyboard_arrow_left_rounded),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.onDateSelect,
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            controller.selectedDateString,
                            style: AppTypography.bodyMedium.semiBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: controller.onNextPressed,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: Color(0xFFD5D7DA), width: 1)),
                      ),
                      child: const Icon(Symbols.keyboard_arrow_right_rounded),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.w),
            Expanded(
              child: Builder(builder: (context) {
                if (controller.viewMode == ViewMode.month) {
                  return _monthView();
                } else if (controller.viewMode == ViewMode.week) {
                  return _weekView();
                } else {
                  return _dayView();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _monthView() {
    return Container(
      color: AppColor.neutralColor.shade50,
      child: Column(
        children: [
          Row(
            children: List.generate(
              7,
              (index) => Expanded(
                child: AspectRatio(
                  aspectRatio: 53.h / 34.w,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.neutralColor.shade10,
                      border: Border(
                        bottom: BorderSide(color: AppColor.neutralColor.shade50, width: 0.5),
                        right: BorderSide(color: AppColor.neutralColor.shade50, width: 0.5),
                        top: BorderSide(color: AppColor.neutralColor.shade50, width: 1),
                        left: BorderSide(color: AppColor.neutralColor.shade50, width: 0.5),
                      ),
                    ),
                    child: Text(
                      controller.weekdays[index],
                      style: AppTypography.bodySmall.semiBold.copyWith(color: AppColor.neutralColor.shade60),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                6,
                (rowIndex) => Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      7,
                      (columnIndex) {
                        final cellIndex = rowIndex * 7 + columnIndex;

                        final (DateTime, List<BookingModel>)? item = controller.displayDateList.elementAtOrNull(cellIndex);

                        return Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColor.neutralColor.shade10,
                              border: Border.all(
                                color: AppColor.neutralColor.shade50,
                                width: 0.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 24.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                        color: (item?.$1.day == DateTime.now().day && item?.$1.month == DateTime.now().month && item?.$1.year == DateTime.now().year) ? AppColor.primaryColor.main : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          item?.$1.day.toString() ?? "",
                                          style: AppTypography.bodySmall.semiBold.copyWith(
                                            color: item?.$1.month == controller.selectedDate.month
                                                ? (item?.$1.day == DateTime.now().day && item?.$1.month == DateTime.now().month && item?.$1.year == DateTime.now().year)
                                                    ? AppColor.neutralColor.shade10
                                                    : AppColor.neutralColor.shade100
                                                : AppColor.neutralColor.shade60,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Wrap(
                                  children: List.generate(
                                    (item?.$2.length ?? 0) > 3 ? 3 : (item?.$2.length ?? 0),
                                    (index) => Container(
                                      height: 8.h,
                                      width: 8.w,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor.main,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                if ((item?.$2.length ?? 0) > 3) ...[
                                  SizedBox(height: 6.h),
                                  Text(
                                    '${(item?.$2.length ?? 0) - 3}+',
                                    style: AppTypography.bodySmall.medium.copyWith(color: AppColor.neutralColor.shade60),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _weekView() {
    return Container();
  }

  Widget _dayView() {
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

        List slots = controller.selectedVenue?.unitList ?? [];
        final double headingColumnWidth = 56.w;
        final double slotHeight = 60.h * 1.25;
        final double slotWidth = 150.w;

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
                            height: slotHeight,
                            width: headingColumnWidth,
                          ),
                          SizedBox(width: headingColumnWidth, child: Divider(color: AppColor.neutralColor.shade50)),
                          ...List.generate(times.length, (index) {
                            var time = times[index];

                            return Container(
                              height: slotHeight,
                              width: headingColumnWidth,
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
                          height: slotHeight * times.length,
                          child: Builder(builder: (context) {
                            Widget buildItem(UnitModel unit) {
                              return SizedBox(
                                width: slotWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: slotHeight,
                                      child: Center(
                                        child: Text(unit.name),
                                      ),
                                    ),
                                    Divider(color: AppColor.neutralColor.shade50),
                                    Expanded(
                                      child: Builder(
                                        builder: (context) {
                                          List<BookingModel> bookings = controller.displayDateList.firstOrNull?.$2 ?? [];

                                          bookings = bookings.where((booking) {
                                            if (booking.unitId != unit.id) return false;

                                            return true;
                                          }).toList();

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
                                                      height: slotHeight,
                                                    );
                                                  },
                                                ),
                                              ),
                                              ...List.generate(bookings.length, (index) {
                                                var booking = bookings[index];
                                                var startTime = booking.startTime!.toDate();
                                                var endTime = booking.endTime!.toDate();

                                                double convertMinutesToPixels(int minutes) {
                                                  double ratio = slotHeight / 60;

                                                  int additionalHeight = minutes % 60;

                                                  return (ratio * minutes + additionalHeight);
                                                }

                                                return Positioned(
                                                  top: slotHeight * startTime.hour,
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

                            if (slots.length < 3) {
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
  }
}
