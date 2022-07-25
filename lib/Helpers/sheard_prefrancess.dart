import 'package:shared_preferences/shared_preferences.dart';

class SheardHelper {
  static late SharedPreferences sheardPref;

 static Future<SharedPreferences> init() async{
    sheardPref = await SharedPreferences.getInstance();
    return sheardPref;
 }

  static Future<bool> setBool(String key, bool value) async {
    return await sheardPref.setBool(key, value);
  }

  static bool? getBool(String key)  {
    return sheardPref.getBool(key);
  }

  static Future<bool> setData(String key, String value) async {
    return await sheardPref.setString(key,value);
  }

  static String? getData(String key)  {
    return sheardPref.getString(key);
  }
  static Future<bool> removeData(String key) async {
    return await sheardPref.remove(key);
  }

}