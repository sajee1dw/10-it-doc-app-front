import 'package:doc/_services/_httpService.dart';
import 'package:doc/models/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class InfolistProvider with ChangeNotifier {
  bool isLoading = false;
  Info _currentInfo;
  Info get currentInfo => _currentInfo;

  Future<Map<String, dynamic>> getInfo(data) async {
    try {
      final http.Response response = await HttpService.getDocInfoList(data);
      print(json.encode(data));
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = json.decode(response.body);
        _currentInfo = Info.fromJson(map);
        print(_currentInfo.docName);
        return {'success': true, 'doctor': _currentInfo};
      } else {
        isLoading = false;
        return {'success': false, 'error': "something went wrong"};
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
