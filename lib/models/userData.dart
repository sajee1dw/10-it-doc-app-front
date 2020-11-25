class UserData {
 
  String startTime;
  String endTime;
  String name;
  // String patient;
  // String idno;
  // String age;
  String address;
  String mobile;
  int bValue;
  String doctorName;

  UserData(
      {
      this.startTime,
      this.endTime,
      this.name,
      // this.patient,
      // this.idno,
      // this.age,
      this.address,
      this.mobile,
      this.bValue,
      this.doctorName,});

  UserData.fromJson(Map<String, dynamic> parsedJson) {
    this.startTime = parsedJson['startDateTime'];
    this.endTime = parsedJson['endDateTime'];
    this.name = parsedJson['name'];
    // this.patient = parsedJson['patient'];
    // this.idno = parsedJson['idNo'];
    // this.age = parsedJson['age'];
    this.address = parsedJson['address'];
    this.mobile = parsedJson['mobile'];
    this.bValue = parsedJson['bvalue'];
    this.doctorName = parsedJson['doctorName'];
  }
}
