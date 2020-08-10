import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  static const String _BASEURL = 'http://10.0.2.2:5000';

  static Future<http.Response> getAreaList() => http
      .get(_BASEURL + '/book-my-doctor-eadd7/us-central1/GetDoctorsAreaList');
  static Future<http.Response> getDocInfoList(data) =>
      http.post(_BASEURL + '/book-my-doctor-eadd7/us-central1/GetInfo',
          body: json.encode(data),
          headers: {'content-type': 'application/json'});
  static Future<http.Response> createPatient(data) =>
      http.post(_BASEURL + '/book-my-doctor-eadd7/us-central1/BookDoctor',
          body: json.encode(data),
          headers: {'content-type': 'application/json'});
  static Future<http.Response> getTimeSlots([date = 0]) => http.post(
      _BASEURL + '/book-my-doctor-eadd7/us-central1/GetDoctorBookingCalendar',
      body: json.encode(date),
      headers: {'content-type': 'application/json'});
}
