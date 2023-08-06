library modern_calendar;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:modern_calendar/src/calendar_tile.dart';

final class CalendarMobilePage extends StatelessWidget {
  const CalendarMobilePage(this._dates, {super.key});

  final List<DateTime> _dates;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const BouncingScrollPhysics(),
      itemCount: _dates.length,
      dragStartBehavior: DragStartBehavior.start,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemBuilder: (_, day) {
        return CalendarTile(date: _dates[day]);
      },
    );
  }
}
