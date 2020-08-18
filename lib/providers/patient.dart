import 'package:doc/_services/_httpService.dart';
import 'package:doc/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PatientProvider with ChangeNotifier {
  bool isLoading = false;
  Patient _currentPatient;
  Patient get currentPatient => _currentPatient;
  Future<Map<String, dynamic>> getPatient(data) async {
    try {
      // isLoading = true;
      //notifyListeners();
      final http.Response response = await HttpService.createPatient(data);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = json.decode(response.body);
        _currentPatient = Patient.fromJson(map);
        //print(map);
        //isLoading = false;
        //notifyListeners();
        return {'success': true, 'patient': _currentPatient};
      } else {
        isLoading = false;
        //notifyListeners();
        return {'success': false, 'error': "something went wrong"};
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
