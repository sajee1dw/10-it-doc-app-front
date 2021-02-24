class Info {
  String clientName;
  String address;
  String shortAddress;
  int phone;
  String appointmentcalendar;
  String bookingcalendar;
  String id;
  String logo;
  Info({
    this.id,
    this.clientName,
    this.address,
    this.shortAddress,
    this.phone,
    this.appointmentcalendar,
    this.bookingcalendar,
    this.logo,
  });

  Info.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.clientName = parsedJson['name'];
    this.address = parsedJson['address'];
    this.shortAddress = parsedJson['shortAddress'];
    this.phone = parsedJson['phone'];
    this.appointmentcalendar = parsedJson['appointmentcalendar'];
    this.bookingcalendar = parsedJson['bookingcalendar'];
    this.logo = parsedJson['logo'];
  }
}
