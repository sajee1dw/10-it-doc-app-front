class Info {
  String docName;
  String docAddress;
  int phone;
  String appointmentcalendar;
  String bookingcalendar;

  Info({
    this.docName,
    this.docAddress,
    this.phone,
    this.appointmentcalendar,
    this.bookingcalendar,
  });

  Info.fromJson(Map<String, dynamic> parsedJson) {
    this.docName = parsedJson['name'];
    this.docAddress = parsedJson['address'];
    this.phone = parsedJson['phone'];
    this.appointmentcalendar = parsedJson['appointmentcalendar'];
    this.bookingcalendar = parsedJson['bookingcalendar'];
  }
}
