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
  /// This is calculated through the last year (current Year - 1)
  /// times 12, so yuo get the number of month up to silvester last year,
  /// and then add the number of month passed by in this year
  static final int _initialPage =
      (DateTime.now().year - 1) * 12 + DateTime.now().month;

  /// Page Controller to this Page View
  static final PageController _pageController = PageController(
    initialPage: _initialPage,
    keepPage: true,
  );

  /// the number of pages that are already rendered.
  /// This is the initial Page plus 2 by default.
  /// It's going up as you scroll through the Pages.
  static int _numberOfRenderedPages = _initialPage + 2;

  /// The current Month to show in this Calendar View
  static int _currentMonth = DateTime.now().month;

  /// The current Year which is to show in this View
  static int _currentYear = DateTime.now().year;

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
        itemCount: _numberOfRenderedPages,
        onPageChanged: (newPage) {
          setState(() {
            if (newPage > _pageController.page!) {
              _currentMonth++;
            } else {
              _currentMonth--;
            }
            if (_currentMonth > 12) {
              _currentMonth -= 12;
              _currentYear++;
            } else if (_currentMonth < 1) {
              _currentMonth += 12;
              _currentYear--;
            }
            _numberOfRenderedPages++;
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
