import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../controllers/application_controller.dart';
import '../../../../controllers/language_service.dart';
import '../../../../shared/extensions/x_datetime.dart';
import '../../../../shared/widgets/list_indicators.dart';
import '../../../../core/design/color.dart';
import '../../../../core/design/typography.dart';
import '../../../../data/enums/booking_status_enum.dart';
import '../../../../data/enums/view_mode_enum.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../data/models/venue_model.dart';
import '../controllers/schedule_page_controller.dart';

class SchedulePage extends GetView<SchedulePageController> {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchedulePageController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Obx(() {
            if (ApplicationController.instance.venueList.value.isNotEmpty) {
              return Row(
                children: [
                  Flexible(
                    child: Text(
                      controller.selectedVenue?.name ?? "",
                      maxLines: 2,
                    ),
                  ),
                  PopupMenuButton<VenueModel>(
                    icon: const Icon(Symbols.keyboard_arrow_down_rounded),
                    itemBuilder: (BuildContext context) => ApplicationController.instance.venueList.value
                        .map((venue) => PopupMenuItem<VenueModel>(
                              value: venue,
                              child: Text(venue.name),
                            ))
                        .toList(),
                    onSelected: controller.onVenueChanged,
                  ),
                ],
              );
            } else {
              return Text(LocaleKeys.schedule.tr);
            }
          }),
          actions: [
            IconButton(
              icon: const Icon(Symbols.today_rounded),
              onPressed: () {
                controller.selectedDate = DateTime.now();
                controller.update();
              },
            ),
            Builder(builder: (context) {
              IconData viewModeIcon;

              switch (controller.viewMode) {
                case ViewMode.day:
                  viewModeIcon = Symbols.calendar_view_day_rounded;
                  break;
                case ViewMode.week:
                  viewModeIcon = Symbols.calendar_view_week_rounded;
                  break;
                case ViewMode.month:
                  viewModeIcon = Symbols.calendar_view_month_rounded;
                  break;
              }

              return PopupMenuButton<ViewMode>(
                icon: Icon(viewModeIcon),
                onSelected: controller.onViewModeChanged,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<ViewMode>>[
                  PopupMenuItem<ViewMode>(
                    value: ViewMode.day,
                    child: Text(LocaleKeys.day_view.tr),
                  ),
                  PopupMenuItem<ViewMode>(
                    value: ViewMode.week,
                    child: Text(LocaleKeys.week_view.tr),
                  ),
                  PopupMenuItem<ViewMode>(
                    value: ViewMode.month,
                    child: Text(LocaleKeys.month_view.tr),
                  ),
                ],
              );
            }),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(0, 64),
            child: SizedBox(
              height: 64,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40.h,
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
                            child: InkWell(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                                  initialDate: controller.selectedDate,
                                  firstDate: DateTime(controller.selectedDate.year - 100, 1, 1),
                                  lastDate: DateTime(controller.selectedDate.year + 100, 12, 31),
                                );

                                if (date != null) {
                                  controller.onDateSelect(date);
                                }
                              },
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
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(thickness: 1.w),
                if (ApplicationController.instance.venueList.value.isNotEmpty)
                  Expanded(
                    child: ScheduleCalendarView(
                      selectedDate: controller.selectedDate,
                      viewMode: controller.viewMode,
                      bookingList: controller.bookingList,
                      slots: controller.selectedVenue?.unitList ?? [],
                      onDateSelect: controller.onDateSelect,
                      onBookingItemPressed: controller.onBookingItemPressed,
                    ),
                  ),
                if (ApplicationController.instance.venueList.value.isEmpty)
                  Expanded(
                    child: Center(
                      child: ListIndicator(
                        icon: Symbols.store_rounded,
                        label: LocaleKeys.you_dont_have_any_venue.tr,
                      ),
                    ),
                  ),
              ],
            )),
        floatingActionButton: Obx(() {
          if (ApplicationController.instance.venueList.value.isNotEmpty) {
            return FloatingActionButton(
              onPressed: controller.onAddBooking,
              child: const Icon(Symbols.calendar_add_on_rounded),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}

class ScheduleCalendarView extends StatefulWidget {
  const ScheduleCalendarView({
    super.key,
    required this.selectedDate,
    required this.viewMode,
    required this.slots,
    required this.bookingList,
    required this.onDateSelect,
    required this.onBookingItemPressed,
  });

  final DateTime selectedDate;
  final ViewMode viewMode;
  final List<UnitModel> slots;
  final List<BookingModel> bookingList;

  final Function(DateTime) onDateSelect;
  final Function(BookingModel) onBookingItemPressed;

  @override
  State<ScheduleCalendarView> createState() => _ScheduleCalendarViewState();
}

class _ScheduleCalendarViewState extends State<ScheduleCalendarView> {
  final ScrollController weekViewSlotScrollController = ScrollController();
  final ScrollController weekViewTimeScrollController = ScrollController();

  final double headingColumnWidth = 56.w;
  final double slotHeight = 60.h * 1.25;
  final double slotWidth = 150.w;

  final List<TimeOfDay> times = [
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

  @override
  void initState() {
    super.initState();

    weekViewSlotScrollController.addListener(_scrollListener);
    weekViewTimeScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    weekViewSlotScrollController.removeListener(_scrollListener);
    weekViewTimeScrollController.removeListener(_scrollListener);
    weekViewSlotScrollController.dispose();
    weekViewTimeScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (weekViewSlotScrollController.position.pixels != weekViewTimeScrollController.position.pixels) {
      if (weekViewSlotScrollController.position.isScrollingNotifier.value) {
        weekViewTimeScrollController.jumpTo(weekViewSlotScrollController.position.pixels);
      } else if (weekViewTimeScrollController.position.isScrollingNotifier.value) {
        weekViewSlotScrollController.jumpTo(weekViewTimeScrollController.position.pixels);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.viewMode) {
      case ViewMode.day:
        return _buildDayView();
      case ViewMode.week:
        return _buildWeekView();
      case ViewMode.month:
        return _buildMonthView();
    }
  }

  List<DateTime> get daysInMonth {
    final List<DateTime> days = [];
    final DateTime firstDay = DateTime(widget.selectedDate.year, widget.selectedDate.month, 1);
    final DateTime lastDay = DateTime(widget.selectedDate.year, widget.selectedDate.month + 1, 0);

    // Add prefix days
    int prefixDays = firstDay.weekday - 1;
    for (int i = prefixDays; i > 0; i--) {
      days.add(firstDay.subtract(Duration(days: i)));
    }

    // Add days of the month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(widget.selectedDate.year, widget.selectedDate.month, i));
    }

    // Add suffix days
    int suffixDays = 42 - days.length;
    for (int i = 1; i <= suffixDays; i++) {
      days.add(lastDay.add(Duration(days: i)));
    }

    return days;
  }

  Widget _buildDayView() {
    if (widget.slots.isEmpty) {
      return ListIndicator(icon: Symbols.sports_martial_arts_rounded, label: LocaleKeys.no_units_found.tr);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      color: AppColor.neutralColor.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Build Slot Row
          SizedBox(
            height: 75.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: headingColumnWidth,
                  decoration: BoxDecoration(color: Colors.white, border: Border(right: BorderSide(color: AppColor.neutralColor.shade50, width: 1.w))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE', LanguageController.instance.currentLocale.languageCode).format(widget.selectedDate),
                        style: AppTypography.bodySmall.semiBold.copyWith(color: AppColor.neutralColor.shade80),
                      ),
                      SizedBox(height: 4.w),
                      Container(
                        height: 24.w,
                        width: 24.w,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor.main,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('d').format(widget.selectedDate),
                            style: AppTypography.bodySmall.semiBold.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.w),
                      SizedBox(
                        height: 4.w,
                        width: 4.w,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    if (widget.slots.length.isLowerThan(3)) {
                      List<Widget> data = [];

                      for (var slot in widget.slots) {
                        data.add(
                          Expanded(
                            child: _buildSlotCell(slot),
                          ),
                        );

                        if (slot.id != widget.slots.last.id) {
                          data.add(const VerticalDivider());
                        }
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: data,
                      );
                    }

                    return ListView.separated(
                      itemCount: widget.slots.length,
                      scrollDirection: Axis.horizontal,
                      controller: weekViewSlotScrollController,
                      physics: const ClampingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) => const VerticalDivider(),
                      itemBuilder: (BuildContext context, int index) {
                        return _buildSlotCell(widget.slots[index]);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),

          SizedBox(height: 1.w),

          // Build Time Column
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Build Time Column
                  SizedBox(
                    width: headingColumnWidth,
                    child: ListView.separated(
                      itemCount: times.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColor.neutralColor.shade50,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var time = times[index];
                        return Container(
                          height: slotHeight,
                          padding: EdgeInsets.only(right: 8.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              right: BorderSide(color: AppColor.neutralColor.shade50, width: 1.w),
                              // bottom: BorderSide(color: AppColor.neutralColor.shade50, width: 1.w),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Transform.translate(
                              offset: Offset(-5.w, -AppTypography.bodySmall.medium.fontSize! / 1.35),
                              child: Text(
                                "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                                style: AppTypography.bodySmall.medium.copyWith(color: index != 0 ? AppColor.neutralColor.shade60 : Colors.transparent),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Build Slot Column
                  Expanded(
                    child: SizedBox(
                      height: slotHeight * times.length + (times.length * 1.w),
                      child: Builder(builder: (context) {
                        Widget buildItem(UnitModel unit) {
                          return SizedBox(
                            width: slotWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      List<BookingModel> bookings = widget.bookingList.where((booking) {
                                        if (booking.status == BookingStatusEnum.confirmed && booking.unit?.id == unit.id) {
                                          return booking.startTime?.toDate().isSameDate(widget.selectedDate) ?? false;
                                        }

                                        return false;
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
                                                return Container(
                                                  width: slotWidth,
                                                  height: slotHeight,
                                                  color: AppColor.neutralColor.shade10,
                                                );
                                              },
                                            ),
                                          ),

                                          // Build Booking Items
                                          ...List.generate(bookings.length, (index) {
                                            var booking = bookings[index];
                                            var startTime = booking.startTime!.toDate();
                                            var endTime = booking.endTime!.toDate();

                                            double convertMinutesToPixels(int minutes) {
                                              double ratio = slotHeight / 60;

                                              int additionalHeight = minutes % 60;

                                              return (ratio * minutes + additionalHeight.h);
                                            }

                                            return Positioned(
                                              top: slotHeight * (startTime.hour + startTime.minute / 60) + 8.h,
                                              height: convertMinutesToPixels(endTime.difference(startTime).inMinutes),
                                              left: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () => widget.onBookingItemPressed(booking),
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                                                  padding: EdgeInsets.all(8.w),
                                                  decoration: BoxDecoration(
                                                    color: booking.color.shade50,
                                                    border: Border.all(color: booking.color.shade200, width: 1.w),
                                                    borderRadius: BorderRadius.circular(6.r),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Text(
                                                        booking.customer?.name ?? LocaleKeys.walk_in_customer.tr,
                                                        style: AppTypography.bodyMedium.semiBold.copyWith(color: booking.color.shade700),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(height: 2.w),
                                                      Text(
                                                        "${booking.startTime?.toDate().formatTime()} - ${booking.endTime?.toDate().formatTime()}",
                                                        style: AppTypography.bodyMedium.regular.copyWith(color: booking.color.shade600),
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

                        if (widget.slots.length.isLowerThan(3)) {
                          List<Widget> data = [];

                          for (var slot in widget.slots) {
                            data.add(Expanded(child: buildItem(slot)));

                            if (slot.id != widget.slots.last.id) {
                              data.add(VerticalDivider(color: AppColor.neutralColor.shade50));
                            }
                          }

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: data,
                          );
                        } else {
                          return ListView.separated(
                            itemCount: widget.slots.length,
                            scrollDirection: Axis.horizontal,
                            controller: weekViewTimeScrollController,
                            physics: const ClampingScrollPhysics(),
                            separatorBuilder: (BuildContext context, int index) {
                              return VerticalDivider(color: AppColor.neutralColor.shade50);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              var slot = widget.slots[index];

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
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    if (widget.slots.isEmpty) {
      return ListIndicator(icon: Symbols.sports_martial_arts_rounded, label: LocaleKeys.no_units_found.tr);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      color: AppColor.neutralColor.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Build Week Row
          SizedBox(
            height: 75.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: headingColumnWidth,
                  padding: EdgeInsets.only(right: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(right: BorderSide(color: AppColor.neutralColor.shade50, width: 1.w)),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      7,
                      (index) {
                        bool isToday = widget.selectedDate.firstDayOfWeek.add(Duration(days: index)).isSameDate(DateTime.now());
                        bool isSelected = widget.selectedDate.firstDayOfWeek.add(Duration(days: index)).isSameDate(widget.selectedDate);
                        List<BookingModel> bookings = widget.bookingList.where((booking) {
                          if (booking.status == BookingStatusEnum.confirmed) {
                            return booking.startTime?.toDate().isSameDate(widget.selectedDate.firstDayOfWeek.add(Duration(days: index))) ?? false;
                          }

                          return false;
                        }).toList();

                        return Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: EdgeInsets.only(right: index == 6 ? 0 : 1.w),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.r)),
                            child: InkWell(
                              onTap: () {
                                widget.onDateSelect(widget.selectedDate.firstDayOfWeek.add(Duration(days: index)));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('EEE', LanguageController.instance.currentLocale.languageCode).format(widget.selectedDate.firstDayOfWeek.add(Duration(days: index))),
                                      style: AppTypography.bodySmall.semiBold.copyWith(color: AppColor.neutralColor.shade80),
                                    ),
                                    SizedBox(height: 4.w),
                                    Container(
                                      height: 24.w,
                                      width: 24.w,
                                      decoration: BoxDecoration(
                                        color: isSelected ? AppColor.primaryColor.main : Colors.transparent,
                                        border: Border.all(color: isToday ? AppColor.primaryColor.main : Colors.transparent),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat('d').format(widget.selectedDate.firstDayOfWeek.add(Duration(days: index))),
                                          style: AppTypography.bodySmall.semiBold.copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : isToday
                                                    ? AppColor.primaryColor.main
                                                    : AppColor.neutralColor.shade80,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.w),
                                    Container(
                                      height: 4.w,
                                      width: 4.w,
                                      decoration: BoxDecoration(
                                        color: bookings.isNotEmpty ? AppColor.primaryColor.main : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 1.w),

          // Build Slot Row
          SizedBox(
            height: 40.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: headingColumnWidth,
                  decoration: BoxDecoration(color: Colors.white, border: Border(right: BorderSide(color: AppColor.neutralColor.shade50, width: 1.w))),
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    if (widget.slots.length.isLowerThan(3)) {
                      List<Widget> data = [];

                      for (var slot in widget.slots) {
                        data.add(
                          Expanded(
                            child: _buildSlotCell(slot),
                          ),
                        );

                        if (slot.id != widget.slots.last.id) {
                          data.add(VerticalDivider(
                            color: AppColor.neutralColor.shade50,
                          ));
                        }
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: data,
                      );
                    }

                    return ListView.separated(
                      itemCount: widget.slots.length,
                      scrollDirection: Axis.horizontal,
                      controller: weekViewSlotScrollController,
                      physics: const ClampingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return VerticalDivider(color: AppColor.neutralColor.shade50);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return _buildSlotCell(widget.slots[index]);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),

          SizedBox(height: 1.w),

          // Build Time Column
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Build Time Column
                  SizedBox(
                    width: headingColumnWidth,
                    child: ListView.separated(
                      itemCount: times.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColor.neutralColor.shade50,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var time = times[index];
                        return Container(
                          height: slotHeight,
                          padding: EdgeInsets.only(right: 8.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              right: BorderSide(color: AppColor.neutralColor.shade50, width: 1.w),
                              // bottom: BorderSide(color: AppColor.neutralColor.shade50, width: 1.w),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Transform.translate(
                              offset: Offset(-5.w, -AppTypography.bodySmall.medium.fontSize! / 1.35),
                              child: Text(
                                "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                                style: AppTypography.bodySmall.medium.copyWith(color: index != 0 ? AppColor.neutralColor.shade60 : Colors.transparent),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Build Slot Column
                  Expanded(
                    child: SizedBox(
                      height: slotHeight * times.length + (times.length * 1.w),
                      child: Builder(builder: (context) {
                        Widget buildItem(UnitModel unit) {
                          return SizedBox(
                            width: slotWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      List<BookingModel> bookings = widget.bookingList.where((booking) {
                                        if (booking.status == BookingStatusEnum.confirmed && booking.unit?.id == unit.id) {
                                          return booking.startTime?.toDate().isSameDate(widget.selectedDate) ?? false;
                                        }

                                        return false;
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
                                                return Container(
                                                  width: slotWidth,
                                                  height: slotHeight,
                                                  color: AppColor.neutralColor.shade10,
                                                );
                                              },
                                            ),
                                          ),

                                          // Build Booking Items
                                          ...List.generate(bookings.length, (index) {
                                            var booking = bookings[index];
                                            var startTime = booking.startTime!.toDate();
                                            var endTime = booking.endTime!.toDate();

                                            double convertMinutesToPixels(int minutes) {
                                              double ratio = slotHeight / 60;

                                              int additionalHeight = minutes % 60;

                                              return (ratio * minutes + additionalHeight.h);
                                            }

                                            return Positioned(
                                              top: slotHeight * (startTime.hour + startTime.minute / 60) + 20.h,
                                              height: convertMinutesToPixels(endTime.difference(startTime).inMinutes),
                                              left: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () => widget.onBookingItemPressed(booking),
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                                                  padding: EdgeInsets.all(8.w),
                                                  decoration: BoxDecoration(
                                                    color: booking.color.shade50,
                                                    border: Border.all(color: booking.color.shade200, width: 1.w),
                                                    borderRadius: BorderRadius.circular(6.r),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Text(
                                                        booking.customer?.name ?? LocaleKeys.walk_in_customer.tr,
                                                        style: AppTypography.bodyMedium.semiBold.copyWith(color: booking.color.shade700),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(height: 2.w),
                                                      Text(
                                                        "${booking.startTime?.toDate().formatTime()} - ${booking.endTime?.toDate().formatTime()}",
                                                        style: AppTypography.bodyMedium.regular.copyWith(color: booking.color.shade600),
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

                        if (widget.slots.length.isLowerThan(3)) {
                          List<Widget> data = [];

                          for (var slot in widget.slots) {
                            data.add(Expanded(child: buildItem(slot)));

                            if (slot.id != widget.slots.last.id) {
                              data.add(VerticalDivider(color: AppColor.neutralColor.shade50));
                            }
                          }

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: data,
                          );
                        } else {
                          return ListView.separated(
                            itemCount: widget.slots.length,
                            scrollDirection: Axis.horizontal,
                            controller: weekViewTimeScrollController,
                            physics: const ClampingScrollPhysics(),
                            separatorBuilder: (BuildContext context, int index) {
                              return VerticalDivider(color: AppColor.neutralColor.shade50);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              var slot = widget.slots[index];

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
        ],
      ),
    );
  }

  Widget _buildMonthView() {
    if (widget.slots.isEmpty) {
      return ListIndicator(icon: Symbols.sports_martial_arts_rounded, label: LocaleKeys.no_units_found.tr);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            color: AppColor.neutralColor.shade50,
            child: Column(
              children: [
                // Build Week Row
                GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 54 / 34,
                  mainAxisSpacing: 1.w,
                  crossAxisSpacing: 1.w,
                  children: List.generate(
                    7,
                    (index) => Container(
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          widget.selectedDate.getWeekdayName(index),
                          style: AppTypography.bodySmall.semiBold.copyWith(color: AppColor.neutralColor.shade80),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 1.w),

                // Build day cells
                GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 54 / 95,
                  mainAxisSpacing: 1.w,
                  crossAxisSpacing: 1.w,
                  children: List.generate(
                    daysInMonth.length,
                    (index) => _buildMonthCell(daysInMonth[index]),
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 1.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('EEEE, MMMM d, yyyy').format(widget.selectedDate),
                style: AppTypography.bodyMedium.semiBold,
              ).paddingSymmetric(horizontal: 16.w),
              SizedBox(height: 16.w),
              Builder(builder: (context) {
                List<BookingModel> bookings = widget.bookingList.where((booking) {
                  return booking.startTime?.toDate().isSameDate(widget.selectedDate) ?? false;
                }).toList();

                if (bookings.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      LocaleKeys.no_bookings_found.tr,
                      style: AppTypography.bodySmall.regular.copyWith(color: AppColor.neutralColor.shade60),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: bookings.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16.w);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    BookingModel booking = bookings[index];

                    // return Text("${booking.startTime?.toDate().formatTime()} - ${booking.endTime?.toDate().formatTime()}");

                    return BookingItem(
                      booking: booking,
                      onBookingItemPressed: (booking) {
                        widget.onBookingItemPressed(booking);
                      },
                    );
                  },
                );
              }),
            ],
          ).paddingSymmetric(vertical: 16.w),
        ],
      ),
    );
  }

  Widget _buildSlotCell(UnitModel slot) {
    return Container(
      width: slotWidth,
      color: Colors.white,
      child: Center(
        child: Text(
          slot.name,
          style: AppTypography.bodySmall.semiBold.copyWith(color: AppColor.neutralColor.shade80),
        ),
      ),
    );
  }

  Widget _buildMonthCell(DateTime date) {
    bool isToday = date.isSameDate(DateTime.now());
    bool isSelected = date.isSameDate(widget.selectedDate);
    bool isMainDays = date.isSameMonth(widget.selectedDate);
    List<BookingModel> bookings = widget.bookingList.where((booking) {
      if (booking.status == BookingStatusEnum.confirmed) {
        return booking.startTime?.toDate().isSameDate(date) ?? false;
      }

      return false;
    }).toList();

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.r)),
      child: InkWell(
        onTap: () {
          widget.onDateSelect(date);
        },
        child: Opacity(
          opacity: isMainDays ? 1 : 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display day
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 24.w,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.primaryColor.main : Colors.transparent,
                    border: Border.all(color: isToday ? AppColor.primaryColor.main : Colors.transparent),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('d').format(date),
                      style: AppTypography.bodySmall.semiBold.copyWith(
                        color: isSelected
                            ? Colors.white
                            : isToday
                                ? AppColor.primaryColor.main
                                : AppColor.neutralColor.shade80,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 6.w),

              Wrap(
                spacing: 4.w,
                runSpacing: 4.w,
                children: bookings
                    .take(3)
                    .map(
                      (booking) => Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: booking.color.shade500,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                    .toList(),
              ),

              if (bookings.length.isGreaterThan(3)) ...[
                SizedBox(height: 6.w),
                Text(
                  "${bookings.length - 3}+",
                  style: AppTypography.bodySmall.semiBold.copyWith(color: AppColor.neutralColor.shade80),
                ),
              ],
            ],
          ).marginAll(6.w),
        ),
      ),
    );
  }
}

class BookingItem extends StatelessWidget {
  final BookingModel booking;
  final Function(BookingModel)? onBookingItemPressed;
  final bool showVenueName;
  final bool showDate;

  const BookingItem({
    super.key,
    required this.booking,
    this.onBookingItemPressed,
    this.showVenueName = false,
    this.showDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onBookingItemPressed?.call(booking),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: booking.color.shade50,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: booking.color.shade200, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.customer?.name ?? LocaleKeys.walk_in_customer.tr,
              style: AppTypography.bodyMedium.semiBold.copyWith(color: booking.color.shade700),
              overflow: TextOverflow.ellipsis,
            ),
            if (showVenueName && booking.venue != null) ...[
              SizedBox(height: 4.h),
              Text(
                booking.venue!.name,
                style: AppTypography.bodySmall.regular.copyWith(color: booking.color.shade700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            SizedBox(height: 4.h),
            Text(
              booking.unit?.name ?? "",
              style: AppTypography.bodySmall.regular.copyWith(color: booking.color.shade700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              showDate ? "${booking.startTime?.toDate().formatDate()} | ${booking.startTime?.toDate().formatTime()} - ${booking.endTime?.toDate().formatTime()}" : "${booking.startTime?.toDate().formatTime()} - ${booking.endTime?.toDate().formatTime()}",
              style: AppTypography.bodySmall.regular.copyWith(color: booking.color.shade700),
            ),
          ],
        ).paddingSymmetric(vertical: 8.w),
      ),
    );
  }

  // Color _getStatusColor() {
  //   switch (booking.status) {
  //     case BookingStatusEnum.pending:
  //       return Colors.orange.withOpacity(0.1);
  //     case BookingStatusEnum.confirmed:
  //       return Colors.green.withOpacity(0.1);
  //     case BookingStatusEnum.cancelled:
  //       return Colors.red.withOpacity(0.1);
  //     case BookingStatusEnum.unknown:
  //     default:
  //       return Colors.grey.withOpacity(0.1);
  //   }
  // }

  // IconData _getStatusIcon() {
  //   switch (booking.status) {
  //     case BookingStatusEnum.pending:
  //       return Symbols.pending_rounded;
  //     case BookingStatusEnum.confirmed:
  //       return Symbols.event_available_rounded;
  //     case BookingStatusEnum.cancelled:
  //       return Symbols.event_busy_rounded;
  //     case BookingStatusEnum.unknown:
  //     default:
  //       return Symbols.event_rounded;
  //   }
  // }

  // void _showBookingDetails(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Container(
  //       padding: EdgeInsets.all(16.w),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             booking.customer?.name ?? LocaleKeys.available.tr,
  //             style: AppTypography.heading6.semiBold,
  //           ),
  //           SizedBox(height: 8.h),
  //           Text(
  //             booking.venue?.name ?? "",
  //             style: AppTypography.bodyMedium.regular,
  //           ),
  //           Text(
  //             booking.unit?.name ?? "",
  //             style: AppTypography.bodyMedium.regular,
  //           ),
  //           SizedBox(height: 8.h),
  //           Text(
  //             "${booking.startTime!.toDate().formatDate()} ${booking.startTime!.toDate().formatTime()} - ${booking.endTime!.toDate().formatTime()}",
  //             style: AppTypography.bodyMedium.regular,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
