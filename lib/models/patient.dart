class Patient {
  String eventName;
  String date;
  String startTime;
  String endTime;
  String name;
  String address;
  String mobile;
  String bValue;
  String title;

  Patient(
      {this.eventName,
      this.date,
      this.startTime,
      this.endTime,
      this.name,
      this.address,
      this.mobile,
      this.bValue,
      this.title});

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        eventName: json["eventName"],
        date: json["date"],
        startTime: json["start"],
        endTime: json["end"],
        name: json["name"],
        address: json["address"],
        mobile: json["mobile"],
        bValue: json["bValue"],
        title: json["title"],
      );
}
