class Company {
  String name;
  String address;
  String id;
  String logo;

  Company({
    this.name,
    this.address,
    this.id,
    this.logo,
  });

  Company.fromJson(Map<String, dynamic> parsedJson) {
    this.name = parsedJson['name'];
    this.address = parsedJson['address'];
    this.id = parsedJson['phone'];
    this.logo = parsedJson['appointmentcalendar'];
  }
}
