import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future initStorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void addPass({required int pass}) {
    prefs.setInt('pass', pass);
  }

  static void addUserId({required String userId}) {
    prefs.setString('userId', userId);
  }

  static String? getUserId() {
    String? userId = prefs.getString('userId');
    return userId;
  }

  static int? getPass() {
    int? pass = prefs.getInt('pass');
    return pass;
  }

  static void clearLocalStorage() {
    prefs.clear();
  }
}
