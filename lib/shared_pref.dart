import 'package:shared_preferences/shared_preferences.dart';
import 'points.dart';

/// shared preferences helper
class SharedPref {
  static const LAST_PRESSED = "lastPressed";
  static const USER_POINTS_EARNED = "userPointsEarned";

  /// get last pressed date for given item id
  static Future<DateTime> getLastPressed(String itemId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String lastPressedString = prefs.getString(_getLastPressedKey(itemId));
    if (lastPressedString == null) return null;

    DateTime lastPressedDate = DateTime.tryParse(lastPressedString);
    if (lastPressedDate == null) return null;

    return lastPressedDate;
  }

  /// set last pressed date to given new value
  static void setLastPressed(String itemId, DateTime newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_getLastPressedKey(itemId), newValue.millisecondsSinceEpoch.toString());
  }

  /// get list of points for given user id
  static Future<List<Points>> getPointsEarned(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> pointsEarnedStrings = prefs.getStringList(_getUserPointsEarnedKey(userId));
    if (pointsEarnedStrings == null) return [];

    return pointsEarnedStrings.map((serialized) => Points.fromString(serialized)).where((o) => o != null).toList();
  }

  /// set entire list of points for given user id
  static void setPointsEarned(String userId, List<Points> pointsEarned) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_getUserPointsEarnedKey(userId), pointsEarned.map((points) => points.toString()).toList());
  }

  /// private
  /// get key for last pressed value
  static String _getLastPressedKey(String itemId) {
    return "$LAST_PRESSED.$itemId";
  }

  static String _getUserPointsEarnedKey(String userId) {
    return "$USER_POINTS_EARNED.$userId";
  }
}
