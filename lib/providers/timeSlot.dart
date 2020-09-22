import 'package:doc/_services/_httpService.dart';
import 'package:doc/models/timeSlot.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TimeSlotProvider with ChangeNotifier {
  bool isLoading = false;
  List<dynamic> timeSlots = [];

  Future<Map<String, dynamic>> getTimeSlots(
      [date = 0, bookingcalendar, appointmentcalendar]) async {
    try {
      if (date == 0) {
        date = {'date': ""};
      }
      isLoading = true;
      notifyListeners();
      final http.Response response = await HttpService.getTimeSlots(date);

      final List responseData = json.decode(response.body);
      print("Time Slot"+response.body);
      if (response.statusCode == 200) {
        List allSlots = [];
        responseData.forEach((element) {
          allSlots.addAll(element);
        });
        timeSlots = allSlots.map((slot) => TimeSlot.fromJson(slot)).toList();
        isLoading = false;
        notifyListeners();
        return {'success': true, 'response': timeSlots};
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
