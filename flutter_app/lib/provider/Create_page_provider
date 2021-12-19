import 'package:flutter_app/calendar_page.dart';
import 'package:flutter_app/model/event.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];
  DateTime _selectedDate = DateTime.now();

  DateTime get selctedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsSelected => _events;

  List<Event> get events => _events;
  addEvent(Event event) {
    // _events.add(event);
    bool allday = true;
    updateCalendare(event);
    notifyListeners();
  }

  clear(Event event) {
    _events = [];
    notifyListeners();
  }

  void addEventList(List<Event> eventList) {
    _events = eventList;
    notifyListeners();
  }
}
