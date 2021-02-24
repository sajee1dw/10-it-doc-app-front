import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  static const String _BASEURL =
      'https://us-central1-bookme10it.cloudfunctions.net';

  static Future<http.Response> getDocInfoList(data) =>
      http.post(_BASEURL + '/GetInfo',
          body: json.encode(data),
          headers: {'content-type': 'application/json'});
  static Future<http.Response> createPatient(data) =>
      http.post(_BASEURL + '/BookClient',
          body: json.encode(data),
          headers: {'content-type': 'application/json'});
  static Future<http.Response> getTimeSlots(
          [date = 0, bookingcalendar, appointmentcalendar]) =>
      http.post(_BASEURL + '/GetClientBookingCalendar',
          body: json.encode(date),
          headers: {'content-type': 'application/json'});
  static Future<http.Response> getUserData(data) =>
      http.post(_BASEURL + '/GetUserData',
          body: json.encode(data),
          headers: {'content-type': 'application/json'});
}
