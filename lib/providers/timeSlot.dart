import 'package:doc/models/timeSlot.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TimeSlotProvider with ChangeNotifier {
  // TimeSlotProvider() {
  //   getTimeSlots();
  // }
  bool isLoading = false;
  List<dynamic> timeSlots = [];

  // List<dynamic> get timeSlots => _timeSlots;

  Future<Map<String, dynamic>> getTimeSlots([date = 0]) async {
    if (date == 0) {
      date = {'date': ""};
    }
    isLoading = true;
    notifyListeners();
    final http.Response response = await http.post(
        'http://10.0.2.2:5000/book-my-doctor-eadd7/us-central1/GetDoctorBookingCalendar',
        body: json.encode(date),
        headers: {'content-type': 'application/json'});
    // print(response.body);
    final List responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      List allSlots = [];
      responseData.forEach((element) {
        allSlots.addAll(element);
      });
      timeSlots = allSlots.map((slot) => TimeSlot.fromJson(slot)).toList();
      print(allSlots);
      isLoading = false;
      notifyListeners();
      return {'success': true, 'response': timeSlots};
    } else {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'error': "something went wrong"};
    }
  }
}
