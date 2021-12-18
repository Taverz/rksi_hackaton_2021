import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'model/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }
  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).froml;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).name;

  @override
  String getDescription(int index) => getEvent(index).description;

  @override
  bool getAllDay(int index) => getEvent(index).allDay;
}
