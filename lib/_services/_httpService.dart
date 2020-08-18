import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  static const String _BASEURL =
      'https://us-central1-book-my-doctor-eadd7.cloudfunctions.net';

  static Future<http.Response> getAreaList() =>
      http.get(_BASEURL + '/GetDoctorsAreaList');
  static Future<http.Response> getDocInfoList(data) =>
      http.post(_BASEURL + '/GetInfo',
          body: json.encode(data),
          headers: {'content-type': 'application/json'});
  static Future<http.Response> createPatient(data) =>
      http.post(_BASEURL + '/BookDoctor',
          body: json.encode(data),
          headers: {'content-type': 'application/json'});
  static Future<http.Response> getTimeSlots(
          [date = 0, bookingcalendar, appointmentcalendar]) =>
      http.post(_BASEURL + '/GetDoctorBookingCalendar',
          body: json.encode(date),
          headers: {'content-type': 'application/json'});
}
