import 'package:shared_preferences/shared_preferences.dart';
import 'points.dart';

/// shared preferences helper
class SharedPref {
  static const LAST_PRESSED = "lastPressed";
  static const USER_POINTS_EARNED = "userPointsEarned";
  static const SEPARATOR = "|";

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
    prefs.setString(_getLastPressedKey(itemId), newValue.toIso8601String());
  }

  /// get list of points for given user id
  static Future<List<Points>> getPointsEarned(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> pointsEarnedStrings = prefs.getStringList(_getUserPointsEarnedKey(userId));
    if (pointsEarnedStrings == null) return [];

    return pointsEarnedStrings.map((serialized) {
      var split = serialized.split(SEPARATOR);
      return Points(int.parse(split[0]), DateTime.parse(split[1]));
    }).where((o) => o != null).toList();
  }

  /// add points earned for given user id
  static void addUserPointsEarned(String userId, Points newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Points> pointsList = await getPointsEarned(userId);
    pointsList.add(newValue);

    prefs.setStringList(_getUserPointsEarnedKey(userId), pointsList.map((points) {
      return "${points.amount}$SEPARATOR${points.earnDate.toIso8601String()}";
    }).toList());
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