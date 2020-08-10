import 'package:doc/_services/_httpService.dart';
import 'package:doc/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PatientProvider with ChangeNotifier {
  bool isLoading = false;
  Patient currentPatient;
  Future<Map<String, dynamic>> createPatient(data) async {
    try {
      isLoading = true;
      notifyListeners();
      final http.Response response = await HttpService.createPatient(data);
      print(response.body);
      if (response.statusCode == 200) {
        currentPatient = Patient.fromJson(data);
        isLoading = false;
        notifyListeners();
        return {'success': true, 'patient': currentPatient};
      } else {
        isLoading = false;
        notifyListeners();
        return {'success': false, 'error': "something went wrong"};
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
