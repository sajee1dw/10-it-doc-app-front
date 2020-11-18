class TimeSlot {
  String date;
  String startTime;
  String endTime;
  String available;
  String fullTitle;

  TimeSlot(
      {this.date, this.startTime, this.endTime, this.available, this.fullTitle});

  TimeSlot.fromJson(Map<String, dynamic> parsedJson) {
    this.date = parsedJson['date'];
    this.startTime = parsedJson['startTime'];
    this.endTime = parsedJson['endTime'];
    this.available = parsedJson['available'];
    this.fullTitle = parsedJson['title'];
  }
}
