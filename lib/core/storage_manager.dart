import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static SharedPreferences? prefs;

  static Future<void> saveData(String key, dynamic value) async {
    StorageManager.prefs ??= await SharedPreferences.getInstance();
    if (value is int) {
      prefs!.setInt(key, value);
    } else if (value is double) {
      prefs!.setDouble(key, value);
    } else if (value is String) {
      prefs!.setString(key, value);
    } else if (value is bool) {
      prefs!.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<void> clear() async {
    StorageManager.prefs ??= await SharedPreferences.getInstance();
    await prefs!.clear();
  }

// returns string value
  static Future<String> getStringData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key) ?? "";
    return value;
  }

// returns int value
  static Future<int> getIntData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(key) ?? 0;
    return value;
  }

// returns object
  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
