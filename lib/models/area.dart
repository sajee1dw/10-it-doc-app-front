// class Area {
//   String areaName;
//   int iD;

//   Area({
//     this.areaName,
//     this.iD,
//   });

//   Area.fromJson(Map<String, dynamic> parsedJson) {
//     this.areaName = parsedJson['Aname'];
//     this.iD = parsedJson['id'];
//   }
// }

// class Suburb {
//   String suburbName;
//   String aname;

//   Suburb({
//     this.suburbName,
//     this.aname,
//   });
//   Suburb.fromJson(Map<String, dynamic> parsedJson) {
//    // print(parsedJson.toString() + ' in consturctor');
//     this.suburbName = parsedJson['Sname'];
//     this.aname = parsedJson['Aname'];
//   }
// }

// class Doctor {
//   String doctorName;

//   Doctor({
//     this.doctorName,
//   });
//   Doctor.fromJson(Map<String, dynamic> parsedJson) {
//     //print(parsedJson.toString() + ' in consturctor');
//     this.doctorName = parsedJson['name'];
//   }

// }
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
