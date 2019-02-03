class Item {
  final ItemConfig config;
  DateTime lastPressed;
  DateTime secondToLastPressed;

  Item(this.config);
}

class ItemConfig {
  final String id;
  final String name;
  final String asset;
  final Duration expectedFrequency;

  ItemConfig(this.id, this.name, this.asset, this.expectedFrequency);
}
