import 'package:shared_preferences/shared_preferences.dart';

class CashService {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveCity({
    required String city,
  }) async {
    return await sharedPreferences.setString('city', city);
  }

  static String? getCity(){
    return sharedPreferences.getString('city');
  }
}
