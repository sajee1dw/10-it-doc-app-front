import 'package:doc/_services/_httpService.dart';
import 'package:doc/models/cacheData.dart';
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
  static SharedPreferences prefs;
  String key;
  Future<Map<String, dynamic>> getInfo(data) async {
    try {
      final http.Response response = await HttpService.getDocInfoList(data);
      print("Doc Info" + response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = json.decode(response.body);
        // print(map);
        _currentInfo = Info.fromJson(map);
        //  print(_currentInfo.docArea);

        _addData();
        init();

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

  init() async {
    prefs = await SharedPreferences.getInstance();
    var cacheData =
        getObjList<CustomModel>("data", (v) => CustomModel.fromJson(v));
    print(cacheData);
    List cacheDataList = cacheData?.map((val) {
      return json.encode(val);
    })?.toList();
    print(cacheDataList.length);
    if (cacheDataList.length == 0) {
      print("*");
      await putObjectList("data", [
        CustomModel(
            id: _currentInfo.id,
            name: _currentInfo.docName,
            address: _currentInfo.docAddress,
            logo: _currentInfo.logo),
      ]);
    } else {
      List<dynamic> values = [];
      cacheData.forEach((element) {
        print(element['id']);
        print(_currentInfo.id);

        values.add(element['id']);
      });
      print("#######");
      print(values);
      if (values.contains(_currentInfo.id)) {
        print("Company Alrady in cache");
      } else {
        print("Adding to cache");
        List<Object> newcacheDataList = [
          CustomModel(
              id: _currentInfo.id,
              name: _currentInfo.docName,
              address: _currentInfo.docAddress,
              logo: _currentInfo.logo)
        ];
        List<String> _dataList = newcacheDataList?.map((value) {
          return json.encode(value);
        })?.toList();
        List<String> newList = new List.from(cacheDataList)..addAll(_dataList);
        prefs.setStringList("data", newList);
      }
    }
  }

  ////////////////////////////////Set String List to cache/////////////////////////////////////////////////////
  static Future<bool> putObjectList(String key, List<Object> list) async {
    if (prefs == null) return null;
    // print(list);
    List<String> _dataList = list?.map((value) {
      return json.encode(value);
    })?.toList();
    return prefs.setStringList(key, _dataList);
  }

///////////////////////////////////////////////////////////////////////////////////////

  static List<Map> getObjList<T>(String key, T f(Map v),
      {List<T> defValue = const []}) {
    if (prefs == null) return null;
    List<Map> dataList = getObjectList(key);
    List<Map> list = dataList;
    return list ?? defValue;
  }

  static List<Map> getObjectList(String key) {
    if (prefs == null) return null;
    List<String> dataList = prefs.getStringList(key);
    return dataList?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }
}

// if (element['id'] != _currentInfo.id) {
//   List<Object> newcacheDataList = [
//     CustomModel(
//         id: _currentInfo.id,
//         name: _currentInfo.docName,
//         address: _currentInfo.docAddress,
//         logo: _currentInfo.logo)
//   ];
//   List<String> _dataList = newcacheDataList?.map((value) {
//     return json.encode(value);
//   })?.toList();
//   List<String> newList = new List.from(cacheDataList)
//     ..addAll(_dataList);
//   prefs.setStringList("data", newList);
// }
