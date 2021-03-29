import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<bool> getBool(String key, bool defaultValue) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key) ?? defaultValue;
  }

  static void setBool(String key, bool b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, b);
  }

  static Future<int> getInt(String key, int defaultValue) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? defaultValue;
  }

  static void setInt(String key, int i) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, i);
  }

  static Future<String> getString(String key, String defaultValue) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? defaultValue;
  }

  static void setString(String key, String s) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(key, s);
  }
}
