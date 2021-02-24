import 'package:bookme/_services/_httpService.dart';
import 'package:bookme/models/cacheData.dart';
import 'package:bookme/models/info.dart';
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
      isLoading = true;
      final http.Response response = await HttpService.getDocInfoList(data);
      print("Client Info" + response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = json.decode(response.body);
        _currentInfo = Info.fromJson(map);

        //    _addData();
        init();
        isLoading = false;
        return {'success': true, 'doctor': _currentInfo};
      } else {
        isLoading = false;
        return {'success': false, 'error': "something went wrong"};
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // _addData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //  // prefs.setString('docArea', _currentInfo.docArea);
  //  // prefs.setString('docSuburb', _currentInfo.docSuburb);
  // }

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
            name: _currentInfo.clientName,
            shortAddress: _currentInfo.shortAddress,
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
              name: _currentInfo.clientName,
              shortAddress: _currentInfo.shortAddress,
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
//         name: _currentInfo.clientName,
//         address: _currentInfo.address,
//         logo: _currentInfo.logo)
//   ];
//   List<String> _dataList = newcacheDataList?.map((value) {
//     return json.encode(value);
//   })?.toList();
//   List<String> newList = new List.from(cacheDataList)
//     ..addAll(_dataList);
//   prefs.setStringList("data", newList);
// }
