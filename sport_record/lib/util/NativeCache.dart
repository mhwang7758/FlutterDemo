import 'package:shared_preferences/shared_preferences.dart';

class NativeCache{
  static final String USER_ID = "uId";

  static Future<String> getData(String key) async {
    print("getData=>"+"key:"+key);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uId = await preferences.getString(key);
    return uId;
  }

  static setData(String key, String uid) async {
    print("setData=>"+key+"->"+uid);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, uid);
  }
}
