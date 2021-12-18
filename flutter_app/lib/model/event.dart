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

  factory Event.fromMap(Map map){
    return Event(
      froml:map["froml"],
      to: map["to"],
      allDay: map["allDay"],
      name:map["date_num"] , 
    description: map["descritption"]
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "date_num":name,
      "to":to,
      "allDay":allDay,
      "name":name,
      "description":description,
    };
  }
}
