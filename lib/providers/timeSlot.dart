import 'package:doc/models/timeSlot.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TimeSlotProvider with ChangeNotifier {
  List<dynamic> _timeSlots = [];

  List<dynamic> get timeSlots => _timeSlots;

  Future<Map<String, dynamic>> getTimeSlots() async {
    final http.Response response = await http.get(
        'http://10.0.2.2:5000/book-my-doctor-eadd7/us-central1/GetDoctorBookingCalendar',
        headers: {'content-type': 'application/json'});
    // print(response.body);
    final List responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      List allSlots = [];
      responseData.forEach((element) {
        allSlots.addAll(element);
      });
      _timeSlots = allSlots.map((slot) => TimeSlot.fromJson(slot)).toList();
      print(allSlots);
      return {'success': true, 'response': _timeSlots};
    } else {
      return {'success': false, 'error': "something went wrong"};
    }
  }
}
