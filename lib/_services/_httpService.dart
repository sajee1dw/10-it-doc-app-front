import 'package:http/http.dart' as http;

class HttpService {
  static const String _BASEURL = 'http://10.0.2.2:5000';

  static Future<http.Response> getAreaList() => 
      http.get(_BASEURL + '/book-my-doctor-eadd7/us-central1/GetDoctorsAreaList');
  static Future<http.Response> getDocInfoList() =>
      http.get(_BASEURL + '/book-my-doctor-eadd7/us-central1/GetInfo');
      // static Future<http.Response> getpatientdetails() =>
      // http.get(_BASEURL + '/book-my-doctor-eadd7/us-central1/BookDoctor');
}
  