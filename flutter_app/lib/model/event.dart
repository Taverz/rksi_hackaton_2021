import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  final String id;
  final String name;
  final String description;
  final DateTime froml;
  final DateTime to;
  final bool allDay;

  const Event(
      {required this.id,
      required this.name,
      required this.description,
      required this.froml,
      required this.to,
      this.allDay = false});

  factory Event.fromMap(Map map) {
    return Event(
        id: map["id"] ?? "",
        froml: DateTime.parse(map["froml"]),
        to: DateTime.parse(map["to"]),
        allDay: false, //map["allDay"],
        name: map["date_num"] ?? "",
        description: map["descritption"] ?? "");
  }

  Map<String, dynamic> toMap() {
    String modifiedReleaseDate;
    if (to != null) {
      DateTime UTCReleaseDateTime = to.toUtc();
      modifiedReleaseDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(UTCReleaseDateTime);
    } else {
      modifiedReleaseDate = "";
    }

    String modifiedReleaseDate2;
    if (froml != null) {
      DateTime UTCReleaseDateTime = froml.toUtc();
      modifiedReleaseDate2 =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(UTCReleaseDateTime);
    } else {
      modifiedReleaseDate2 = "";
    }
    return {
      "date_num": name,
      "to": modifiedReleaseDate,
      "allDay": allDay,
      "froml": modifiedReleaseDate2,
      "name": name,
      "description": description,
    };
  }
}
