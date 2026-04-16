import 'dart:convert';

import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late final SharedPreferences prefs;

  static const String kToken = 'token';
  static const String kUSer = 'user';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserInfo(User? user) async {
    if (user == null) return;
    var objToJson = user.toJson();
    var jsonToString = jsonEncode(objToJson);
    await prefs.setString(kUSer, jsonToString);
  }

  static User? getUserInfo(String kUSer) {
    var cashedString = prefs.getString(kUSer);
    if (cashedString == null) return null;
    var stringToJson = jsonDecode(cashedString);
    return User.fromJson(stringToJson);
  }

  static Future<void> saveToken(String? token) async {
    if (token == null) return;
    await prefs.setString(kToken, token);
  }

  static String getToken() {
    return prefs.getString(kToken) ?? '';
  }

  static Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String getString(String key) {
    return prefs.getString(key) ?? '';
  }

  static Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool getBool(String key) {
    return prefs.getBool(key) ?? false;
  }
}
