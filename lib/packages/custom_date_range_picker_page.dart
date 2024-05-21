import 'package:flutter/material.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:qr_animations/base_page.dart';

class CustomDateRangePickerPage extends StatefulWidget {
  const CustomDateRangePickerPage({super.key});

  @override
  State<CustomDateRangePickerPage> createState() => _CustomDateRangePickerPageState();
}

class _CustomDateRangePickerPageState extends State<CustomDateRangePickerPage> {
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return BasePage(
      package: "custom_date_range_picker",
      widgets: [
        Text("${startDate.toString()}"),
        Text("${endDate.toString()}"),
      ],
      fab: FloatingActionButton(
        onPressed: () {
          showCustomDateRangePicker(
            context,
            dismissible: true,
            minimumDate: DateTime.now().subtract(const Duration(days: 30)),
            maximumDate: DateTime.now().add(const Duration(days: 30)),
            endDate: endDate,
            startDate: startDate,
            backgroundColor: Colors.white,
            primaryColor: Colors.green,
            onApplyClick: (start, end) {
              setState(() {
                endDate = end;
                startDate = start;
              });
            },
            onCancelClick: () {
              setState(() {
                endDate = null;
                startDate = null;
              });
            },
          );
        },
        tooltip: 'choose date Range',
        child: const Icon(Icons.calendar_today_outlined, color: Colors.white),
      ),
    );
  }
}
