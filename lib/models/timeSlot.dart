import 'package:flutter/foundation.dart';

class TimeSlot {
  String startTime;
  String endTime;
  int slot;

  TimeSlot({this.startTime, this.endTime, this.slot});

  TimeSlot.fromJson(Map<String, dynamic> parsedJson) {
    this.startTime = parsedJson['startTime'];
    this.endTime = parsedJson['endTime'];
    this.slot = parsedJson['slot'];
  }
}
