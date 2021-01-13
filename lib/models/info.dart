class Info {
  String docName;
  String docAddress;
  int phone;
  String appointmentcalendar;
  String bookingcalendar;
  String docArea;
  String docSuburb;
  String id;
  String logo;
  Info({
    this.id,
    this.docName,
    this.docAddress,
    this.phone,
    this.appointmentcalendar,
    this.bookingcalendar,
    this.docArea,
    this.docSuburb,
    this.logo,
  });

  Info.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.docName = parsedJson['name'];
    this.docAddress = parsedJson['address'];
    this.phone = parsedJson['phone'];
    this.appointmentcalendar = parsedJson['appointmentcalendar'];
    this.bookingcalendar = parsedJson['bookingcalendar'];
    this.docArea = parsedJson['area'];
    this.docSuburb = parsedJson['suburb'];
    this.logo = parsedJson['logo'];
  }
}
