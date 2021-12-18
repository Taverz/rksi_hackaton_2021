import 'package:flutter/material.dart';

class Event {
  final String name;
  final String description;
  final DateTime froml;
  final DateTime to;
  final bool allDay;

  const Event(
      {required this.name,
      required this.description,
      required this.froml,
      required this.to,
      this.allDay = false});
}
