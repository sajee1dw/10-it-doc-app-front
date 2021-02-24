import 'package:bookme/_services/_httpService.dart';
import 'package:bookme/models/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class UserDataProvider with ChangeNotifier {
  bool isLoading = false;
  List<dynamic> userData = [];

  Future<Map<String, dynamic>> getUserData(data) async {
    isLoading = true;
    notifyListeners();
    final http.Response response = await HttpService.getUserData(data);
    try {
      final List responseData = json.decode(response.body);
      print("Unique user data"+response.body);
      if (response.statusCode == 200) {
        List allData = [];
        responseData.forEach((element) {
          allData.addAll(element);
        });
        userData =
            allData.map((datalist) => UserData.fromJson(datalist)).toList();
        isLoading = false;
        notifyListeners();
        return {'success': true, 'response': userData};
      } else {
        isLoading = false;
        notifyListeners();
        return {'success': false, 'error': "something went wrong"};
      }
    } catch (e) {
      throw Exception(e.message.toString());
    }
  }
 


}
