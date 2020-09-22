import 'package:doc/_services/_httpService.dart';
import 'package:doc/models/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class InfolistProvider with ChangeNotifier {
  bool isLoading = false;
  Info _currentInfo;
  Info get currentInfo => _currentInfo;

  Future<Map<String, dynamic>> getInfo(data) async {
    try {
      final http.Response response = await HttpService.getDocInfoList(data);
      print("Doc Info"+response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = json.decode(response.body);
        _currentInfo = Info.fromJson(map);
        _addData();
        return {'success': true, 'doctor': _currentInfo};
      } else {
        isLoading = false;
        return {'success': false, 'error': "something went wrong"};
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  _addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('docArea', _currentInfo.docArea);
    prefs.setString('docSuburb', _currentInfo.docSuburb);
  }
}
