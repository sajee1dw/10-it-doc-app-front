class Patient {
  String eventName;
  DateTime startTime;
  DateTime endTime;
  String name;
  String patient;
  String idno;
  int age;
  String address;
  String mobile;

  Patient(
      {this.eventName,
        this.startTime,
      this.endTime,
      this.name,
      this.patient,
      this.idno,
      this.age,
      this.address,
      this.mobile});

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        eventName: json["eventName"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        name: json["name"],
        patient: json["patientName"],
        idno: json["idno"],
        age: int.parse(json["age"]),
        address: json["address"],
        mobile: json["mobile"],
      );
}
