// import 'package:doc/_services/_httpService.dart';
// import 'package:doc/models/area.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// class ArealistProvider {
//   static Future<Map<String, dynamic>> getAreaList() async {
//     try {
//       final http.Response response = await HttpService.getAreaList();
//       print("Area List"+response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         List<Area> areas = [];
//         List<Sub> suburbs = [];
//         List<Doctor> doctors = [];
//         Map<String, dynamic> data = json.decode(response.body);
//         List<Map<String, dynamic>>.from(data['areas'] ?? []).forEach((element) {
//           areas.add(Area.fromMap(element));
//         });
//         List<Map<String, dynamic>>.from(data['suburbs'] ?? [])
//             .forEach((element) {
//           suburbs.add(Sub.fromMap(element));
//         });
//         List<Map<String, dynamic>>.from(data['doctors'] ?? [])
//             .forEach((element) {
//           doctors.add(Doctor.fromMap(element));
//         });
//         return {'areas': areas, 'suburbs': suburbs, 'doctors': doctors};
//       } else {
//         throw Exception(response.statusCode);
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
