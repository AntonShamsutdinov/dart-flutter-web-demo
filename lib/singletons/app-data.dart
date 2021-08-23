import 'dart:io';
import 'package:http/http.dart' as http;

class AppData {
  static final AppData _appData = new AppData._internal();

  String accessToken = '';
  String baseUri = '';
  http.Client httpClient = http.Client();

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}
final appData = AppData();