import 'package:flutter/material.dart';
import './date_utils.dart';
import './clean_calendar_event.dart';
import "package:intl/intl.dart";


class CalendarTile extends StatelessWidget {
  final VoidCallback? onDateSelected;
  final DateTime? date;
  final String? dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool inMonth;
  final List<Calendar_Booking>? events;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? dateStyles;
  final Widget? child;
  final Color? selectedColor;
  final Color? todayColor;
  final Color? eventColor;
  final Color? eventDoneColor;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyle,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.inMonth: true,
    this.events,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
          alignment: Alignment.center,
          child: Text(
            dayOfWeek ?? '',
            style: dayOfWeekStyle,
          ),
        ),
      );
    } else {
      int eventCount = 0;
      return InkWell(
        onTap: onDateSelected, // react on tapping
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: isSelected && date != null
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedColor != null
                        ? Utils.isSameDay(this.date!, DateTime.now())
                            ? Colors.grey
                            : selectedColor
                        : Theme.of(context).primaryColor,
                  )
                : BoxDecoration(), // no decoration when not selected
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  date != null ? DateFormat("d").format(date!) : '',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: isSelected && this.date != null
                          ? Colors.white
                          : Utils.isSameDay(this.date!, DateTime.now())
                              ? todayColor
                              : inMonth
                                  ? Colors.black
                                  : Colors
                                      .grey), // Grey color for previous or next months dates
                ),
                events != null && events!.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: events!.map((event) {
                          eventCount++;
                          if (eventCount > 3) return Container();
                          return Container(
                            margin: EdgeInsets.only(
                                left: 2.0, right: 2.0, top: 1.0),
                            width: 5.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (() {
                                  if (event.isDone)
                                    return eventDoneColor ??
                                        Theme.of(context).primaryColor;
                                  if (isSelected) return Colors.white;
                                  return eventColor ??
                                      Theme.of(context).accentColor;
                                }())),
                          );
                        }).toList())
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
