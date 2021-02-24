import 'package:bookme/_services/_httpService.dart';
import 'package:bookme/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PatientProvider with ChangeNotifier {
  bool isLoading = false;
  Patient _currentPatient;
  Patient get currentPatient => _currentPatient;
  Future<Map<String, dynamic>> getPatient(data) async {
    try {
       isLoading = true;
      //notifyListeners();
      final http.Response response = await HttpService.createPatient(data);
      print("Patient Data"+response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = json.decode(response.body);
        _currentPatient = Patient.fromJson(map);
       
        //notifyListeners();
        _addData();
         isLoading = false;
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

  _addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', currentPatient.name);
    prefs.setString('address', currentPatient.address);
    prefs.setString('mobile', currentPatient.mobile);
    prefs.setString('bValue', currentPatient.bValue);
  }
}
