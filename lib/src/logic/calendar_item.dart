library modern_calendar;

import 'package:flutter/material.dart' show Color, Colors;
import 'package:modern_calendar/src/logic/location.dart' show Location;

abstract class CalendarItem {
  const CalendarItem({
    required this.startTime,
    required this.endTime,
    required this.title,
    this.color = Colors.orange,
  });

  final DateTime startTime;

  final DateTime endTime;

  final String title;

  final Color color;
}

class DefaultCalendarItem extends CalendarItem {
  const DefaultCalendarItem({
    required super.startTime,
    required super.endTime,
    required super.title,
    this.notes,
    this.location,
  });

  final String? notes;

  final Location? location;
}
