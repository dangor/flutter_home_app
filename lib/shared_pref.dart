import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const LAST_PRESSED = "lastPressed";

  static Future<DateTime> getLastPressed(String itemId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String lastPressedString = prefs.getString(_getLastPressedKey(itemId));
    if (lastPressedString == null) return null;

    DateTime lastPressedDate = DateTime.tryParse(lastPressedString);
    if (lastPressedDate == null) return null;

    return lastPressedDate;
  }

  static void setLastPressed(String itemId, DateTime newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_getLastPressedKey(itemId), newValue.toIso8601String());
  }

  static String _getLastPressedKey(String itemId) {
    return "$LAST_PRESSED.$itemId";
  }
}