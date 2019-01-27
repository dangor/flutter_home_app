/// How long ago was the given time?
class HowLongAgo {
  static String was(DateTime time) {
    if (time == null) {
      return "";
    }

    Duration diff = DateTime.now().difference(time);
    String diffString;

    if (diff.inSeconds.abs() < 45) {
      diffString = "a few seconds";
    } else if (diff.inMinutes.abs() < 2) {
      diffString = "a minute";
    } else if (diff.inMinutes.abs() < 45) {
      diffString = "${diff.inMinutes.abs()} minutes";
    } else if (diff.inHours.abs() < 2) {
      diffString = "an hour";
    } else if (diff.inHours.abs() < 22) {
      diffString = "${diff.inHours.abs()} hours";
    } else if (diff.inDays.abs() < 2) {
      diffString = "a day";
    } else if (diff.inDays.abs() < 26) {
      diffString = "${diff.inDays.abs()} days";
    } else if (diff.inDays.abs() < 60) {
      diffString = "a month";
    } else {
      diffString = "${diff.inDays.abs() ~/ 30} months";
    }

    return "$diffString ago";
  }
}
