class Points {
  final int amount;
  final DateTime earnDate;
  final String itemId;

  Points(this.amount, this.earnDate, this.itemId);

  @override
  String toString() {
    return "$amount$SEPARATOR${earnDate.millisecondsSinceEpoch.toString()}$SEPARATOR$itemId";
  }

  static Points fromString(String s) {
    if (s == null) return null;

    var split = s.split(SEPARATOR);
    if (split.length < 2) return null;

    var amount = int.parse(split[0]);

    var millis = int.parse(split[1]);
    if (millis == null) return null;
    var earnDate = DateTime.fromMillisecondsSinceEpoch(millis);
    if (earnDate == null) return null;

    String itemId;
    if (split.length >= 3) {
      itemId = split[2];
    }

    return Points(amount, earnDate, itemId);
  }

  static const SEPARATOR = "|";
}