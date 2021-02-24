class UserData {
  String startTime;
  String endTime;
  String name;
  String address;
  String mobile;
  int bValue;
  String clientName;

  UserData({
    this.startTime,
    this.endTime,
    this.name,
    this.address,
    this.mobile,
    this.bValue,
    this.clientName,
  });

  UserData.fromJson(Map<String, dynamic> parsedJson) {
    this.startTime = parsedJson['startDateTime'];
    this.endTime = parsedJson['endDateTime'];
    this.name = parsedJson['name'];
    this.address = parsedJson['address'];
    this.mobile = parsedJson['mobile'];
    this.bValue = parsedJson['bvalue'];
    this.clientName = parsedJson['userName'];
  }
}
