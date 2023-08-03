library components;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:modern_calendar/src/CalendarTile.dart';

/// The Mobile Calendar View which displays a Calendar
/// scaled for mobile usage.
final class CalendarMobileView extends StatefulWidget {
  const CalendarMobileView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CalendarMobileViewState();
  }
}

final class _CalendarMobileViewState extends State<CalendarMobileView> {
  int _currentMonth = DateTime.now().month;

  int _currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> currentMonth =
        _generateDatesForMonth(_currentMonth, _currentYear);
    return Scrollable(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      axisDirection: AxisDirection.down,
      physics: const BouncingScrollPhysics(),
      dragStartBehavior: DragStartBehavior.start,
      viewportBuilder: (_, __) {
        return Container();
      },
    );
    ListView.builder(
        itemCount: 12,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        itemBuilder: (_, month) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 4,
            ),
            itemBuilder: (_, day) {
              return CalendarTile(date: currentMonth[day]);
            },
          );
        });
  }

  /// Generates a List with all dates
  /// in the specified Month and Year
  List<DateTime> _generateDatesForMonth(int month, int year) {
    final List<DateTime> result = [];
    for (int day = 0; day < _getDayCountForMonth(month, year); day++) {
      result.add(DateTime(year, month, day));
    }
    return result;
  }

  /// Generates a List with all dates
  /// in the specified Year
  List<DateTime> _generateDatesForYear(int year) {
    final List<DateTime> result = [];
    for (int month = 0; month < 12; month++) {
      result.addAll(_generateDatesForMonth(month, year));
    }
    return result;
  }

  /// Returns the number of days in the specified
  /// month and year
  int _getDayCountForMonth(int month, int year) {
    final int dayCount;
    if (month == 2) {
      dayCount = (year % 4 == 0) ? 29 : 28;
    } else if ((month <= 7 && month.isOdd) || month > 7 && month.isEven) {
      dayCount = 31;
    } else {
      dayCount = 30;
    }
    return dayCount;
  }
}
