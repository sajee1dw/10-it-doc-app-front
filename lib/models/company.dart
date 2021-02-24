class Company {
  String name;
  String shortAddress;
  String id;
  String logo;

  Company({
    this.name,
    this.shortAddress,
    this.id,
    this.logo,
  });

  Company.fromJson(Map<String, dynamic> parsedJson) {
    this.name = parsedJson['name'];
    this.shortAddress = parsedJson['shortAddress'];
    this.id = parsedJson['phone'];
    this.logo = parsedJson['appointmentcalendar'];
  }
}
