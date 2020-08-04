class TimeSlot {
  String date;
  String startTime;
  String endTime;
  int slot;

  TimeSlot({this.date, this.startTime, this.endTime, this.slot});

  TimeSlot.fromJson(Map<String, dynamic> parsedJson) {
    this.date = parsedJson['date'];
    this.startTime = parsedJson['startTime'];
    this.endTime = parsedJson['endTime'];
    this.slot = parsedJson['slot'];
  }
}
