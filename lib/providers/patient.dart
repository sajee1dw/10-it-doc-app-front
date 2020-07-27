import 'package:doc/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PatientProvider with ChangeNotifier {
  Patient currentPatient;
  Future<Map<String, dynamic>> createPatient(data) async {
    // final String apiUrl = "https://reqres.in/api/users";
    // final http.Response response = await HttpService.getpatientdetails();
    final http.Response response = await http.post(
        'http://10.0.2.2:5000/book-my-doctor-eadd7/us-central1/BookDoctor',
        body: json.encode(data),
        headers: {'content-type': 'application/json'});
    print(response.body);
    // final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      currentPatient = Patient.fromJson(data);
      return {'success': true, 'patient': currentPatient};
    } else {
      return {'success': false, 'error': "something went wrong"};
    }
  }
}

// response body date == data  date
