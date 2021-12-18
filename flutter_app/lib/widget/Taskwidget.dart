import "package:flutter/material.dart";
import 'package:flutter_app/calendar_page.dart';
import 'package:flutter_app/event_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_app/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_app/Calendar/viev_event_page.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvent = provider.eventsSelected;

    if (selectedEvent.isEmpty) {
      //Если нет мероприятий
      return Center(
        child: Text('No events found'),
      );
    }
    return SfCalendarTheme(
        data: SfCalendarThemeData(
            timeTextStyle: TextStyle(fontSize: 16, color: Colors.black)),
        child: SfCalendar(
          headerHeight: 0,
          view: CalendarView.timelineDay, //Показывать в режиме таймлайн
          dataSource: EventDataSource(provider.events), //Мероприятия
          initialDisplayDate: provider.selctedDate, //Выбранная дата
          appointmentBuilder: appointmentBuilder, //Внутренности
          todayHighlightColor: Colors.purple,
          selectionDecoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.5),
          ),
          //Недоделанный переход на мероприятие
          //   onTap: (details) {
          //     if (details.appointments == null) return;
          //     final event = details.appointments!.first;

          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => ViewEvent(event: event)));
          //   },
        ));
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
          color: Color.fromRGBO(247, 234, 251, 0.8),
          borderRadius: BorderRadius.circular(10)), //Получение размеров
      child: Text(
        event.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
