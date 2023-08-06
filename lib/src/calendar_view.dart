library modern_calendar;

import 'dart:io' show Platform;

import 'package:flutter/material.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:modern_calendar/modern_calendar.dart'
    show CalendarDesktopView, CalendarMobileView;

final class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    if (_isDesktop) {
      return const CalendarDesktopView();
    } else {
      return const CalendarMobileView();
    }
  }

  bool get _isDesktop {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }
}
