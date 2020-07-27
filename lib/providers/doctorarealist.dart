import 'package:doc/_services/_httpService.dart';
import 'package:doc/models/area.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ArealistProvider {
  //await Future.delayed(Duration(seconds: 4));

  static Future<Map<String, dynamic>> getAreaList() async {
    try {
      final http.Response response = await HttpService.getAreaList();
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Area> areas = [];
        List<Sub> suburbs = [];
        List<Doctor> doctors = [];
        Map<String, dynamic> data = json.decode(response.body);
        List<Map<String, dynamic>>.from(data['areas'] ?? []).forEach((element) {
          areas.add(Area.fromMap(element));
        });
        List<Map<String, dynamic>>.from(data['suburbs'] ?? [])
            .forEach((element) {
          suburbs.add(Sub.fromMap(element));
        });
        List<Map<String, dynamic>>.from(data['doctors'] ?? [])
            .forEach((element) {
          doctors.add(Doctor.fromMap(element));
        });
        return {'areas': areas, 'suburbs': suburbs, 'doctors': doctors};
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

// class ArealistProvider {
//   static Future<List<Area>> getAreaList() async {
//     final http.Response response = await HttpService.getAreaList();
//     List<Area> results1 = [];

//     if (response.statusCode == 200) {
//       Map<String, dynamic> map = json.decode(response.body);
//       List<Map<String, dynamic>> areaListMap =
//           List<Map<String, dynamic>>.from(map['areas']);
//       for (var element in areaListMap) {
//         results1.add(Area.fromJson(element));
//       }
//     }

//     return results1;
//   }

//   static Future<List<Suburb>> getSuburbList() async {
//     final http.Response response = await HttpService.getAreaList();
//     List<Suburb> results2 = [];

//     if (response.statusCode == 200) {
//       Map<String, dynamic> map = json.decode(response.body);
//       List<Map<String, dynamic>> suburbListMap =
//           List<Map<String, dynamic>>.from(map['suburbs']);
//       for (var element in suburbListMap) {
//        // print(element);
//         Suburb suburb = Suburb.fromJson(element);
//        // print(suburb.suburbName);
//         results2.add(suburb);
//       }
//     }
//     //results2.forEach((element) {print(element.suburbNname);});

//     return results2;
//   }

//   static Future<List<Doctor>> getDoctorList() async {
//     final http.Response response = await HttpService.getAreaList();
//     List<Doctor> results3 = [];

//     if (response.statusCode == 200) {
//       Map<String, dynamic> map = json.decode(response.body);
//       List<Map<String, dynamic>> doctorListMap =
//           List<Map<String, dynamic>>.from(map['doctors']);
//       for (var element in doctorListMap) {
//         results3.add(Doctor.fromJson(element));
//       }
//     }

//     return results3;
//   }

// }

//    static Future<Class1> getSome() async {
//     final http.Response response = await HttpService.getAreaList();

//     if(response.statusCode == 200){
//       Map<String, dynamic> map = json.decode(response.body);
//       return Class1.fromJson(map);
//     }

//     throw Exception('GetSome error');
//   }
// }

// class ArealistProvider {
//   Future<Arealist> fetchStatus() async {
//     final response =await http.get('https://hpb.health.gov.lk/api/get-current-statistical');
// if (response.statusCode == 200) {
// //final Map<String, dynamic> responseData = json.decode(response.body);
// return Arealist.fromJson(json.decode(response.body));
//     } else {
//      // If that call was not successful, throw an error.
//     throw Exception('Failed to load post');
//   }
// }}

// Map<String, dynamic> map = json.decode(response.body);
// List<dynamic> data = map["dataKey"];
// print(data[0]["name"]);

// class StatusProvider {
//   Future<Situation> getStatus() async {
//     final http.Response response =
//         await http.get('https://hpb.health.gov.lk/api/get-current-statistical');
//     final Map<String, dynamic> responseData = json.decode(response.body);
//     print(responseData);
//     return Situation.fromJson(responseData['data']);
//   }
// }

// class ArealistProvider {
//   Future<List<Arealist>> getStatus() async {
//     final http.Response response =
//         await http.get('http://10.0.2.2:5000/book-my-doctor-eadd7/us-central1/GetDoctorsAreaList');
//      var jsonData  = json.decode(response.body);
//      List<Arealist> arealists = [];
//      for(var u in jsonData){
//         Arealist arealist = Arealist.fromjson;
//         arealists.add(arealist);
//      }
//     print(arealists.length);
//   return arealists;

//   }
// }
