library modern_calendar;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:modern_calendar/src/Mobile/calendar_mobile_page.dart';
import 'package:modern_calendar/src/calendar_view_type.dart';

/// The Mobile Calendar View which displays a Calendar
/// scaled for mobile usage.
final class CalendarMobileView extends StatefulWidget {
  const CalendarMobileView({this.type = CalendarViewType.month, super.key});

  final CalendarViewType type;

  @override
  State<CalendarMobileView> createState() => _CalendarMobileViewState();
}

final class _CalendarMobileViewState extends State<CalendarMobileView> {
  /// Page Controller to this Page View
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  /// The current Month to show in this Calendar View
  int _currentMonth = DateTime.now().month;

  /// The current Year which is to show in this View
  int _currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    if (widget.type == CalendarViewType.year) {
      return const Text('Not implemented yet');
    } else {
      final List<DateTime> currentMonth =
          _generateDatesForMonth(_currentMonth, _currentYear);
      final List<DateTime> previousMonth = _generateDatesForMonth(
        _currentMonth - 1 < 1 ? 12 : _currentMonth - 1,
        _currentMonth - 1 < 1 ? _currentYear - 1 : _currentYear,
      );
      final List<DateTime> nextMonth = _generateDatesForMonth(
        _currentMonth + 1 > 12 ? 0 : _currentMonth + 1,
        _currentYear + 1 > 12 ? _currentYear + 1 : _currentYear,
      );
      return PageView.builder(
        allowImplicitScrolling: true,
        controller: _pageController,
        dragStartBehavior: DragStartBehavior.down,
        padEnds: false,
        pageSnapping: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        // 5 to always render the current page + 2 in every direction
        itemCount: 5,
        onPageChanged: (newMonth) {
          setState(() {
            _currentMonth = newMonth;
          });
        },
        itemBuilder: (_, __) {
          return CalendarMobilePage(currentMonth);
        },
      );
    }
  }

  /// Generates a List with all dates
  /// in the specified Month and Year
  List<DateTime> _generateDatesForMonth(int month, int year) {
    final List<DateTime> result = [];
    for (int day = 1; day <= _getDayCountForMonth(month, year); day++) {
      result.add(DateTime(year, month, day));
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
