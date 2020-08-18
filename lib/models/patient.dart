class Patient {
  String eventName;
  String date;
  String startTime;
  String endTime;
  String name;
  String patient;
  String idno;
  String age;
  String address;
  String mobile;
  String bValue;

  Patient(
      {this.eventName,
      this.date,
      this.startTime,
      this.endTime,
      this.name,
      this.patient,
      this.idno,
      this.age,
      this.address,
      this.mobile,
      this.bValue});

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        eventName: json["eventName"],
        date: json["date"],
        startTime: json["start"],
        endTime: json["end"],
        name: json["name"],
        patient: json["patient"],
        idno: json["idno"],
        age: json["age"],
        address: json["address"],
        mobile: json["mobile"],
        bValue: json["bValue"],
      );
}
