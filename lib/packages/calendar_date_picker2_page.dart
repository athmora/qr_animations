import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:qr_animations/base_page.dart';

class CalendarDatePicker2Page extends StatefulWidget {
  const CalendarDatePicker2Page({super.key});

  @override
  State<CalendarDatePicker2Page> createState() => _CalendarDatePicker2PageState();
}

class _CalendarDatePicker2PageState extends State<CalendarDatePicker2Page> {
  List<DateTime?> _dates = [];
  @override
  Widget build(BuildContext context) {
    return BasePage(
      package: "calendar_date_picker2",
      widgets: [
        CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.range,
            firstDayOfWeek: 1,
            selectedDayHighlightColor: Colors.purple[800],
            dayBorderRadius: BorderRadius.circular(8),
            monthBorderRadius: BorderRadius.circular(12),
            centerAlignModePicker: true,
          ),
          value: _dates,
          onValueChanged: (dates) {
            if (dates.isNotEmpty && dates.first != null) {
              _dates = getNearestPeriod(dates.first!);
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  List<DateTime> getNearestPeriod(DateTime date) {
    List<DateTime> nearest = [];

    int daysBetween = date.weekday - DateTime.monday;

    if (daysBetween < 0) {
      daysBetween += 7;
    }

    DateTime nearestBackMonday = date.subtract(Duration(days: daysBetween));
    nearest = [
      nearestBackMonday,
      nearestBackMonday.add(const Duration(days: 7)),
    ];

    return nearest;
  }
}
