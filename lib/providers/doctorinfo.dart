import 'package:doc/_services/_httpService.dart';
import 'package:doc/models/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// class InfolistProvider {
//   static Future<Info> getInfo() async {
//     final http.Response response = await HttpService.getDocInfoList();

//     if (response.statusCode == 200) {
//       Map<String, dynamic> map = json.decode(response.body);
//       return Info.fromJson(map);
//     }

//     throw Exception('GetSome error');
//   }
// }
class InfolistProvider with ChangeNotifier {
  bool isLoading = false;
  Info _currentInfo;
  Info get currentInfo => _currentInfo;

  Future<Map<String, dynamic>> getInfo(data) async {
    // final String apiUrl = "https://reqres.in/api/users";
    // final http.Response response = await HttpService.getpatientdetails();
    final http.Response response = await http.post(
        'http://10.0.2.2:5000/book-my-doctor-eadd7/us-central1/GetInfo',
        body: json.encode(data),
        headers: {'content-type': 'application/json'});
    print(json.encode(data));
    // final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      //return map;
      _currentInfo = Info.fromJson(map);
      print(_currentInfo.docName);
      return {'success': true, 'doctor': _currentInfo};
    } else {
      isLoading = false;
      return {'success': false, 'error': "something went wrong"};
    }
  }
}
