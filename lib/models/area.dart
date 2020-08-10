class Area {
  int id;
  String aName;

  Area({this.id, this.aName});

  Area.fromMap(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.aName = parsedJson['aName'];
  }
}

class Sub {
  int id;
  String sName;
  String aName;

  Sub({this.id, this.sName, this.aName});

  Sub.fromMap(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.sName = parsedJson['sName'];
    this.aName = parsedJson['aName'];
  }
}

class Doctor {
  int id;
  String name;
  String suburb;
  String area;

  Doctor({this.id, this.name, this.area, this.suburb});

  Doctor.fromMap(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.name = parsedJson['name'];
    this.suburb = parsedJson['suburb'];
    this.area = parsedJson['area'];
  }
}
