library modern_calendar;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:helpful_extensions/helpful_extensions.dart';
import 'package:modern_calendar/src/calendar_tile.dart';

final class CalendarMobilePage extends StatelessWidget {
  const CalendarMobilePage(this._dates, {super.key});

  final List<DateTime> _dates;

  @override
  Widget build(BuildContext context) {
    int numberOfDaysBeforeCount =
        Weekday.values.indexOf(_dates[0].weekdayAsEnum);
    final int numberOfDaysBefore = numberOfDaysBeforeCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      verticalDirection: VerticalDirection.down,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: [
            Text(Weekday.monday.abbreviation),
            Text(Weekday.tuesday.abbreviation),
            Text(Weekday.wednesday.abbreviation),
            Text(Weekday.thursday.abbreviation),
            Text(Weekday.friday.abbreviation),
            Text(Weekday.saturday.abbreviation),
            Text(Weekday.sunday.abbreviation),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
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
            if (numberOfDaysBeforeCount > 0) {
              numberOfDaysBeforeCount--;
              return Container();
            } else {
              day -= numberOfDaysBefore;
              return CalendarTile(date: _dates[day]);
            }
          },
        ),
      ],
    );
  }
}
