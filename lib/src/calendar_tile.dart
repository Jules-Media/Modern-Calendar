library modern_calendar;

import 'package:flutter/material.dart';
import 'package:helpful_extensions/helpful_extensions.dart' show Weekday;

final class CalendarTile extends StatelessWidget {
  const CalendarTile({required this.date, super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        //backgroundBlendMode: BlendMode.hue,
        shape: BoxShape.rectangle,
      ),
      position: DecorationPosition.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: [
          Text(date.weekdayAsString),
          Text(date.day.toString()),
        ],
      ),
    );
  }
}
