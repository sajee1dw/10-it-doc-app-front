class Info {
  String docName;
  String docAddress;
  int phone;
  String appointmentcalendar;
  String bookingcalendar;
  String docArea;
  String docSuburb;

  Info({
    this.docName,
    this.docAddress,
    this.phone,
    this.appointmentcalendar,
    this.bookingcalendar,
    this.docArea,
    this.docSuburb,
  });

  Info.fromJson(Map<String, dynamic> parsedJson) {
    this.docName = parsedJson['name'];
    this.docAddress = parsedJson['address'];
    this.phone = parsedJson['phone'];
    this.appointmentcalendar = parsedJson['appointmentcalendar'];
    this.bookingcalendar = parsedJson['bookingcalendar'];
    this.docArea = parsedJson['area'];
    this.docSuburb = parsedJson['suburb'];
  }
}
