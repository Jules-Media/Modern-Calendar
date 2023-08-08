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
  /// The initial Page on which
  /// the Page Controller starts
  static const int _initialPage = 1;

  int _numberOfActivelyRenderedPages = 3;

  bool _reverse = false;

  /// Page Controller to this Page View
  final PageController _pageController = PageController(
    initialPage: _initialPage,
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
      return PageView.builder(
        allowImplicitScrolling: true,
        controller: _pageController,
        dragStartBehavior: DragStartBehavior.down,
        padEnds: false,
        pageSnapping: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _numberOfActivelyRenderedPages,
        reverse: _reverse,
        onPageChanged: (newPage) {
          setState(() {
            if (newPage > _pageController.page!) {
              _reverse = false;
            } else {
              _reverse = true;
            }
            _numberOfActivelyRenderedPages++;
            _currentMonth += (newPage - _initialPage);
            if (_currentMonth > 12) {
              _currentMonth -= 12;
              _currentYear++;
            } else if (_currentMonth < 1) {
              _currentMonth += 12;
              _currentYear--;
            }
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
