library components;

import 'package:flutter/material.dart';
import 'package:modern_calendar/src/calendar_tile.dart';

final class CalendarDesktopView extends StatelessWidget {
  const CalendarDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarTile(date: DateTime.now());
  }
}
