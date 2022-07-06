// ignore_for_file: prefer_const_declarations, unused_field

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService extends GetxService {
  static SharedPreferences _preferences;

  static final _keyIsFirstLog = 'isFirstLog';
  static final _keyIsLogged = '_keyIsLogged';
  static final _keyFirst = 'true';
  static final _keyStatus = 'unlogged';
  static final _keyUserId = 'userId';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future clear() async {
    _preferences.clear();
  }

  static Future setIsFirstLog(bool userId) async {
    await _preferences.setBool(_keyIsFirstLog, userId);
  }

  static bool getIsFirstLog() {
    final data = _preferences.getBool(_keyIsFirstLog);

    if (data != null) return data;
    return null;
  }

  static Future setIsLogged(bool userId) async {
    await _preferences.setBool(_keyIsLogged, userId);
  }

  static bool getIsLogged() {
    final data = _preferences.getBool(_keyIsLogged);

    if (data != null) return data;
    return null;
  }

  static Future setStatus(String status) async {
    await _preferences.setString(_keyStatus, status);
  }

  static String getStatus() {
    final data = _preferences.getString(_keyStatus);

    if (data != null) return data;
    print(data);

    return null;
  }

  static Future setFirst(String first) async {
    await _preferences.setString(_keyFirst, first);
  }

  static String getFirst() {
    final data = _preferences.getString(_keyFirst);

    if (data != null) return data;
    print(data);
    return null;
  }
}
